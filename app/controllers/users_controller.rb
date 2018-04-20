class UsersController < ApplicationController
  before_action :logged_in_user, except: [:create, :new, :check_billing]
  # before_action :correct_user,   only: [:edit, :update]
  def new
    session[:invitation_token] = params[:invitation_token] if params[:invitation_token]
    if session[:invitation_token]
      @invitation = Invitation.find_by(token: session[:invitation_token])
      @user = User.new(invitation_id: @invitation.id)
      @user.first_name = @invitation.recipient_first_name
      @user.last_name = @invitation.recipient_last_name
      @user.email = @invitation.recipient_email
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
    params.has_key?(:auth) ? @auth = true : @auth = false
    params.has_key?(:tab) ? @nav = true : @nav = false
    @address = Address.find_or_create_by!(user_id: @user.id)
    @viewable = User.current_user_or_doctor? @user, current_user
    @profile = Profile.find_or_create_by!(user_id: @user.id)
    @subscription = Subscription.find_or_create_by!(user_id: @user.id)
    @bank_account = BankAccount.find_or_create_by!(user_id: @user.id)
    @complaints = @user.complaints.uniq.pluck(:name)
    @appointments = Appointment.where("patient_id = ? OR doctor_id = ?", @user.id, @user.id)
    @comments = @user.comments

    if current_user.oauth_token && current_user.refresh_token
      begin
        @calendar_list = GoogleCalendarWrapper.new(current_user).get_calendar_list
      rescue Signet::AuthorizationError => err
        @sync_error = err
      end
    end

    @response = StripeAccountWrapper.retrieve_account(current_user) if current_user.stripe_id
    @missing_account_information = StripeAccountWrapper.retrieve_needed_verification_information(@response) if @response
    @settings = AppointmentSetting.find_or_create_by!(user_id: @user.id)
    @days = current_user.days
    @practice = @user.practices.empty? ? @user.practices.build : @user.practices.first
    @document = Document.new
    @documents = @user.documents

  end

  def check_billing
    user = User.find(params[:doctor_id])
    @billing_rate = AppointmentSetting.find_by(user_id: user.id).billing_rate
    respond_to do |format|
      format.json {render json: @billing_rate}
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if @user.invitation_id
          @relationship = Relationship.new(patient_id: @user.id, doctor_id: Invitation.find(@user.invitation_id).sender_id, status: "confirmed")
          @relationship.save
          ReminderMailer.patient_accepted(@relationship).deliver
      end
      @user.send_activation_email
      flash[:success] = "Please check your email to activate your account."
      redirect_to root_url
    else
      flash[:danger] = "There was an issue registering your account.  Please try again.  If the problem persists, contact us."
      render 'new'
    end
  end

  def index
  end

  def patients
    patient_ids = Relationship.where("doctor_id = ? AND status= ?", current_user.id, 2).pluck(:patient_id)
    @patients = []
    patient_ids.each do |id|
      @patients << User.find(id)
    end
  end

  def doctors
    doctor_ids = current_user.doctors.pluck(:doctor_id)
    @doctors = []
    doctor_ids.each do |id|
      @doctors << User.find(id)
    end
  end

  def search
    @email = params[:user_email]
    @user = User.find_by(email: @email)
    @request = Relationship.find_by("patient_id = ? AND doctor_id = ?", @user.id, current_user.id) unless @user.nil?
    respond_to do |format|
      format.js
    end
  end


  def calendar_auth
    user = User.from_omniauth(env["omniauth.auth"], current_user.email)
    @details = env["omniauth.auth"]
    flash[:success] = "You have authorized your account, now you must select a calendar to sync."
    redirect_to user_path(current_user, auth: true)
  end


  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)

    user_params.key?("stripe_bank_token") ? @verification = true : verification = false

    # sync calendar
    if user_params.key?("google_calendar_id")
      calendar_sync @user
    end
    Rails.logger.info(@user.errors.inspect)
    respond_to do |format|
      format.js
    end
end

private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :primary_phone, :password_confirmation, :invitation_id, :google_calendar_id,:stripe_bank_token,
                                  address_attributes: [:id, :number, :street, :apartment, :city, :state, :zip])
    end

  def calendar_sync user
    cal = GoogleCalendarWrapper.new user
    cal.get_calendar_events user, user.next_goog_cal_sync_token
    cal.send_calendar_events_to_google user
    flash[:success] = "Your calendars are now synced!"
  end



end
