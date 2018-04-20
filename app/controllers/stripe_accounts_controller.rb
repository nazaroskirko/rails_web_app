class StripeAccountsController < ApplicationController


  def create
    @response = StripeAccountWrapper.create_account current_user, params[:country]
    @missing_account_information = StripeAccountWrapper.retrieve_needed_verification_information @response
    respond_to do |format|
      format.js
    end
  end

  def update
    @response = StripeAccountWrapper.update_account current_user, params, request.remote_ip
    redirect_to controller: "users", action: "show", id: current_user.id, tab: 'verification'
  end

end
