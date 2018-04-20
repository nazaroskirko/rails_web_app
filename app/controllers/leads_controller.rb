class LeadsController < ApplicationController
  def new
    @lead = Lead.new
  end

  def create
    @lead = Lead.new lead_params
    attempt_to_save_lead @lead
  end

  def edit
    @lead = Lead.find params[:id]
  end

  def update
    @lead = Lead.find params[:id]
    @lead.save
    respond_to do |format|
      format.js
    end
  end

  private
  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email, :phone, anonymous_id:[], inquiries_attributes: [:id, :message, :lead_id])
  end

  def attempt_to_save_lead lead
      if lead.save
        send_notification_emails @lead
        redirect_to new_user_path, notice: "Thanks for the inquiry.  We will reach out to you shortly.  Please feel free to open a free account in the meantime."
      else
        redirect_to root_path, alert: "Oops, looks like you made a mistake or 20."
      end
  end

  def send_notification_emails lead
    LeadNotifierMailer.send_home_form_email(lead).deliver
    LeadNotifierMailer.send_home_form_internal_notification(lead).deliver
  end
end
