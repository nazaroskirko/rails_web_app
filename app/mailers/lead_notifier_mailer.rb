class LeadNotifierMailer < ApplicationMailer
  default :from => 'dan@patientnotes.co'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_home_form_email(lead)
    @lead = lead
    mail( :to => @lead.email,
    :subject => "The answer you seek" )
  end

  def send_home_form_internal_notification(lead)
    @lead = lead
    mail( :to => 'dan@patientnotes.co',
    :subject => 'Patient Notes Inquiry' )
  end

end
