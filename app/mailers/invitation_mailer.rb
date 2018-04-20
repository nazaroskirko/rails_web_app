class InvitationMailer < ApplicationMailer
  default from:  'noreply@patientnotes.co'

  def patient invitation, signup_url
    @greeting = "Hi"
    @doctor = User.find(invitation.sender_id)
    @signup_url = signup_url.gsub("p.", "p/")
    @invitation = invitation
    mail(to: "#{invitation.recipient_first_name} #{invitation.recipient_last_name} <#{invitation.recipient_email}>", subject:"Invitation: Patient Notes")
    @invitation.update_attribute(:sent_at, Time.now)
  end
end
