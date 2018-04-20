class ReminderMailer < ApplicationMailer
  default from:  'noreply@patientnotes.co'


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.connection.subject
  #
  def connection relationship, confirm_relationship_url
    @patient = User.find(relationship.patient_id)
    @doctor = User.find(relationship.doctor_id)
    @confirmation_url = confirm_relationship_url.gsub("nt.", "nt/")
    mail(to: "#{@patient.first_name} #{@patient.last_name} <#{@patient.email}>", subject:"Invitation: Patient Notes")
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.appointment.subject
  #
  def appointment
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def patient_appointment_request appointment
    @appointment = appointment
    @patient = User.find(appointment.patient_id)
    @doctor = User.find(appointment.doctor_id)
    mail(to: "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", subject:"#{@patient.first_name} #{@patient.last_name} would like to schedule an appointment.")
  end

  def doctor_appointment_confirmation appointment
    @appointment = appointment
    @patient = User.find(appointment.patient_id)
    @doctor = User.find(appointment.doctor_id)
    mail(to: "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", subject:"You have a new appointment!")
  end

  def patient_appointment_confirmation appointment
    @appointment = appointment
    @patient = User.find(appointment.patient_id)
    @doctor = User.find(appointment.doctor_id)
    mail(to: "#{@patient.first_name} #{@patient.last_name} <#{@patient.email}>", subject:"Your session has been scheduled!")
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.session.subject
  #
  def session
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def patient_accepted relationship
    @patient = User.find(relationship.patient_id)
    @doctor = User.find(relationship.doctor_id)
    mail(to: "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", subject:"#{@patient.first_name} #{@patient.last_name} accepted your invitation")
  end

  def patient_declined relationship
    @patient = User.find(relationship.patient_id)
    @doctor = User.find(relationship.doctor_id)
    mail(to: "#{@doctor.first_name} #{@doctor.last_name} <#{@doctor.email}>", subject:"#{@patient.first_name} #{@patient.last_name} accepted your invitation")

  end


end
