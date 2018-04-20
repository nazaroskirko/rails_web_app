# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/connection
  def connection
    ReminderMailer.connection
  end

  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/appointment
  def appointment
    ReminderMailer.appointment
  end

  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/session
  def session
    ReminderMailer.session
  end

end
