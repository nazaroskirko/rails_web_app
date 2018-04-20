class BankAccountsController < ApplicationController

    def update
      @account = BankAccount.find(params[:id])
      @account.update_attributes(account_params)
      StripeAccountWrapper.add_external_account current_user
      redirect_to controller: "users", action: "show", id: current_user.id, tab: 'verification'
    end





  private

  def account_params
    params.require(:bank_account).permit(:stripe_token)
  end
  end
