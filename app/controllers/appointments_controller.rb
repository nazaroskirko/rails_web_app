require 'date'

class AppointmentsController < ApplicationController
  include AppointmentsHelper
  skip_before_filter :verify_authenticity_token
  before_action :logged_in_user, except: [:create]
  def new
    @appointment = Appointment.new()
    if params[:doctor_id].present?
      @scheduling_user = "patient"
      @doctors_array = current_user.doctors.collect{ |p| ["#{p.first_name} #{p.last_name}", p.id] }
      @selected_doctor_id = params[:doctor_id]
      @doctor_options = @doctors_array
    else
      @scheduling_user = "doctor"
      @patients_array = current_user.patients.collect{ |p| ["#{p.first_name} #{p.last_name}", p.id] }
      @selected_patient_id = params[:patient_id]
      @patient_options = @patients_array
    end
    respond_to do |format|
      format.js {@scheduling_user}
    end
  end


  def edit
    @appointment = Appointment.find(params[:id])
    if params[:doctor_id].present?
      @scheduling_user = "patient"
      @doctors_array = current_user.doctors.collect{ |p| ["#{p.first_name} #{p.last_name}", p.id] }
      @selected_doctor_id = params[:doctor_id]
      @doctor_options = @doctors_array
    else
      @scheduling_user = "doctor"
      @patients_array = current_user.patients.collect{ |p| ["#{p.first_name} #{p.last_name}", p.id] }
      @selected_patient_id = @appointment.patient_id
      @patient_options = @patients_array
    end
    respond_to do |format|
      format.js {@scheduling_user}
      format.json  { render :json => @appointment.patient_id }
    end
  end


  def create
    appt_params = app_params
    p appt_params

    start = DateTime.strptime("#{appt_params['date']} #{appt_params['start']}", '%Y-%m-%d %l:%M %p')
    end_time = DateTime.strptime("#{appt_params['date']} #{appt_params['end']}", '%Y-%m-%d %l:%M %p')

    date = Date.parse(appt_params['date'])
    puts date
    end_date = date
    puts end_date
    # TODO look me up (confirm this is + 6months)
    end_date += 26*7
    puts end_date


    interval = 0
    if appt_params['recurrence'] == 'weekly'
      interval = 7
    elsif appt_params['recurrence'] == 'biweekly'
      interval = 14
    elsif appt_params['recurrence'] == 'monthly'
      interval = 28
    end
    appt_params.delete 'recurrence'

    # while appt_params['date'] < end_date do
    while Date.parse(appt_params['date']) < end_date do
      create_appointment(appt_params)
      summed_date = Date.parse(appt_params['date']) + interval
      appt_params['date'] = summed_date.to_s

      if interval.zero?
        break
      end
    end

    respond_to do |format|
      if @external
        format.js {render 'external_create'}
        format.html {redirect_to booking_complete_path(@appointment.id),flash: {success: "You booked your appointment"}}
      else
        format.js
      end
    end
end

def update
  @appointment = Appointment.find(params[:id])
  @response = @appointment.update_attributes(app_params)
  respond_to do |format|
    format.js {}
  end
end

  def index
    @events = []
    current_user.appointments.where(status: ["confirmed","synced"]).each do |a|
      event = {:class => "bg-success-lighter"}


      event["title"] = get_title a


      # if a.status == "synced"
      #   event[:class] << " synced_event"
      # end
      event[:class] << " #{a.event_type}_class"
      event["appid"] = a.id
      
      event["start"] = DateTime.new(a.date.year, a.date.month, a.date.day, a.start.hour, a.start.min, a.start.sec, a.start.zone).strftime('%Y-%m-%dT%H:%M:%S')
      event["end"] = DateTime.new(a.date.year, a.date.month, a.date.day, a.end.hour, a.end.min, a.end.sec, a.end.zone).strftime('%Y-%m-%dT%H:%M:%S')
      @events << event.to_json
    end

  end

  def calendar_sync
    cal = GoogleCalendarWrapper.new current_user
    cal.get_calendar_events current_user, current_user.next_goog_cal_sync_token
    cal.send_calendar_events_to_google current_user
    respond_to do |format|
      format.js
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
    unless @appointment.patient_id
      flash[:info] = "There's nothing to show you. This is a Synced Google event!"
      redirect_to :back and return
    end
    @patient = User.find(@appointment.patient_id)
    @doctor = User.find(@appointment.doctor_id)
    if current_user.id == @patient.id || current_user.id == @doctor.id
      @comments = @appointment.comments
    else
      flash[:danger] = "That wasn't for your eyes!!!"
      redirect_to @user
    end
  end

private

def create_appointment(apt_params)
  @appointment = Appointment.new(apt_params)
  @external = @appointment.status == 'guest_booking' ? true : false
  @charge_response = @appointment.charge_guest( params[:stripeToken], params[:patient_name], params[:patient_email], params[:patent_form], params[:appointment_type]) if @external

  if (@external && @charge_response) || @external == false
    if @appointment.save
      @response = true
    else
      @response = false
    end
  else
    @response = false
  end
end

def app_params
  params.require(:appointment).permit(:patient_id, :doctor_id, :date, :start, :end, :status, :recurrence, :event_type, :cpt_code)
end


end
