class Appointment < ApplicationRecord
  enum status: [:requested,:confirmed,:cancelled,:late_cancel,:completed,:reviewed, :synced, :guest_booking]
  enum event_type: [:appointment, :group_event, :personal_event, :google_event]
  enum reocurring: [:once, :weekly, :biweekly, :monthly]
  enum cpt_code: CPT_CODES.map{|key,val| "<b>#{key}</b> - #{val}" }

  attr_accessor :recurrence

  has_many :comments, as: :commentable
  before_save :check_confirmed
  TIMES = [["5:00 AM", "5:00 AM"], ["5:30 AM", "5:30 AM"],["6:00 AM", "6:00 AM"],["6:30 AM", "6:30 AM"],["7:00 AM", "7:00 AM"],["7:30 AM", "7:30 AM"],["8:00 AM", "8:00 AM"],["8:30 AM", "8:30 AM"],["9:00 AM", "9:00 AM"],["9:30 AM", "9:30 AM"],["10:00 AM", "10:00 AM"],["10:30 AM", "10:30 AM"],["11:00 AM", "11:00 AM"],["11:30 AM", "11:30 AM"],["12:00 PM", "12:00 PM"],["12:30 PM", "12:30 PM"],["1:00 PM", "1:00 PM"],["1:30 PM", "1:30 PM"],["2:00 PM", "2:00 PM"],["2:30 PM", "2:30 PM"],["3:00 PM", "3:00 PM"],["3:30 PM", "3:30 PM"],["4:00 PM", "4:00 PM"],["4:30 PM", "4:30 PM"],["5:00 PM", "5:00 PM"],["5:30 PM", "5:30 PM"],["6:00 PM", "6:00 PM"],["6:30 PM", "6:30 PM"],["7:00 PM", "7:00 PM"],["7:30 PM", "7:30 PM"],["8:00 PM", "8:00 PM"],["8:30 PM", "8:30 PM"],["9:00 PM", "9:00 PM"],["9:30 PM", "9:30 PM"],["10:00 PM", "10:00 PM"],["10:30 PM", "10:30 PM"]]
  def create_google_calendar_event
    user = User.find(self.doctor_id)
    calendar = GoogleCalendarWrapper.new(user) if user.oauth_token && user.refresh_token
    calendar.send_event_to_google user, self
  end


  def check_confirmed
    if self.status == "confirmed" && self.patient_id
      ReminderMailer.patient_appointment_confirmation(self).deliver
      ReminderMailer.doctor_appointment_confirmation(self).deliver
      #self.create_google_calendar_event
    elsif self.status == "requested" && self.patient_id
      ReminderMailer.patient_appointment_request(self).deliver
    elsif self.status == 'guest_booking' && self.patient_id.nil?
        return true
    end
    return true
  end

  def self.charge_confirmed_appointments
    appointments = Appointment.where("status = ? AND date = ?", Appointment.statuses["confirmed"].to_i, Date.today+22.days)
    appointments.each do |a|
      a.charge_customer
    end
  end


  def charge_guest stripe_card_token, patient_name, patient_email, patient_phone, appointment_type
    return self.update_attributes(end: self.start + 30.minutes) if appointment_type == "Consultation"
    bill_handler = StripeAccountWrapper.new
    self.update_attributes(end: self.start + 1.hour)
    charge = bill_handler.charge_guest stripe_card_token, self.doctor_id
    charge ? self.update_attributes(paid: true) : false
  end

  def charge_customer
    if self.try(:paid) == nil && self.date <= Date.today && self.status == "completed"
      charge = StripeAccountWrapper.bill_customer self.patient_id, self.doctor_id
      self.paid = true if charge
      self.save
    end
  end

  def self.update_or_create_goog_event user, google_id, a_start, a_end, status, title
    event = user.appointments.find_by(doctor_goog_event_id: google_id)
    if event
      if status == "cancelled"
        event.status = 2
        event.save
      else
        if a_start
          event.update_attributes(start: a_start.to_time.strftime('%I:%M %p'), end: a_end.to_time.strftime('%I:%M %p'), date: a_start.to_time.strftime('%Y-%m-%d'), title: title)
        end
      end
    else
      if a_start
        a = Appointment.new(event_type: :google_event, doctor_id: user.id, status: 6, start: a_start.to_time.strftime('%I:%M %p'), end: a_end.to_time.strftime('%I:%M %p'), date: a_start.to_time.strftime('%Y-%m-%d'), doctor_goog_event_id: google_id, title: title)
        a.save
      end
    end
  end

  def is_doctor? user
    doctor_id == user.id
  end

  def is_patient? user
    patient_id == user.id
  end

end
