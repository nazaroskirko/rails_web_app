class InvitationsController < ApplicationController
  before_action :logged_in_user
  def new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender_id = current_user.id
    if @invitation.save
      InvitationMailer.patient(@invitation, signup_url(@invitation.token)).deliver
      respond_to do |format|
        format.js {}
      end
    else
      flash[:danger] = "Whoops.  Something went wrong, please resend the invitation"
      redirect_to patients_user_path(current_user)
    end
  end


  private

  def invitation_params
    params.require(:invitation).permit(:recipient_email, :recipient_first_name, :recipient_last_name)
  end
end
