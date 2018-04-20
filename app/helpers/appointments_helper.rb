module AppointmentsHelper

  def get_options selected_user_id, users_to_return
    users_to_return == 'patients' ? options = @patient_options : options = @doctor_options
    options ||= [["No Doctors Found", 4]]
    if selected_user_id
      options_for_select(options, selected_user_id)
    else
      options_for_select(options)
    end
  end

  def get_cpt_options
  	Appointment.cpt_codes.map do |cpt|
  		cpt[0]
  	end
  end

  def get_title appointment
    case appointment.event_type
      when "appointment"
        # current_user.id == appointment.doctor_id ? "#{User.find(appointment.patient_id).name}" : "#{User.find(appointment.doctor_id).name}"
        # "Dr. #{User.find(appointment.doctor_id).name} and #{User.find(appointment.patient_id).name}"
        "#{User.find(appointment.patient_id).name}"
      when "google_event"
        appointment.title
      when "group_event"
        "group_event".humanize
      when "personal_event"
        "personal_event".humanize
      else
        'Legacy event!'
      end
  end

end
