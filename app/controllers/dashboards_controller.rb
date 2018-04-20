class DashboardsController < ApplicationController
  before_action :logged_in_user
  def show
    @dashboard = Dashboard.new(current_user)
    @user = current_user
    @profile = Profile.find_or_create_by!(user_id: @user.id)
    @subscription = Subscription.find_or_create_by!(user_id: @user.id)
    @address = Address.find_or_create_by!(user_id: @user.id)
    @viewable = User.current_user_or_doctor? @user, current_user
    @complaints = @user.complaints.uniq.pluck(:name)

    appointments = Appointment.where("patient_id = ? OR doctor_id = ? AND date > ?", @user.id, @user.id, Time.now).sort_by{|a| a.date}
    @appointments = appointments.first(5)
    @late = Appointment.where("patient_id = ? OR doctor_id = ? AND date < ? AND status != ?", @user.id, @user.id, Date.today - 5.days, 5).first(5)
    @comments = @user.comments
  end

end
