class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to appointments_path(current_user)
        # redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email and password combination'
      render 'new'
    end
  end

  def destroy
    # log_out if logged_in
    params[:session] = nil
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    puts params
    puts session.inspect
    puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    session.destroy
    flash[:warning] = "You have successfully logged out"
    redirect_to root_url
  end
end