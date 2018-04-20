class UserComplaintsController < ApplicationController

  def create
    @new_complaints = []
    @current_user = current_user
    @complaints = params[:user_complaint][:complaint_id]
    @complaints.each do |c|
      complaint = UserComplaint.new(complaint_id: c, user_id: @current_user.id)
      complaint.save
      @new_complaints << complaint.id
    end
    @names = @current_user.complaints.uniq.pluck(:name)
    @list = ""
      @names.each do |n|
        @list = @list + "<button class='btn btn-default m-b-5 m-r-5'>#{n}</span>"
      end
    respond_to do |format|
      format.js {}
    end
  end

private
  def complaint_params
    params.require(:user_complaint).permit(complaint_id: [])
  end
end
