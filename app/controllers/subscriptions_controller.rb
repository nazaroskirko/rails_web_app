class SubscriptionsController < ApplicationController

  def update
    @subscription = Subscription.find(params[:id])
    @subscription.update_attributes(subscription_params)
    StripeAccountWrapper.create_customer current_user, params['subscription']['stripe_token'], params['subscription']["plan"]
    flash[:success] = "You have successfully subscribed to the #{current_user.subscription.plan.titleize} plan."
    redirect_to controller: "users", action: "show", id: current_user.id, tab: 'verification'
  end





private

def subscription_params
  params.require(:subscription).permit(:stripe_token, :plan)
end
end
