class PracticesController < ApplicationController
  layout 'external/booking', only: [:show, :booking_complete]

  def show
    @practice = Practice.find_by(slug: params[:id])
    @appointment = Appointment.new
    @doctors = @practice.doctors
  end

  def new
    @practice = Practice.new()
  end

  def create
    @practice = Practice.new(practice_params)
    @response = @practice.save
    PracticeDoctor.find_or_create_by(practice_id: @practice.id, doctor_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end

  def update
    @practice = Practice.find(params[:id])
    @response = @practice.update_attributes(practice_params)
    PracticeDoctor.find_or_create_by(practice_id: @practice.id, doctor_id: current_user.id)
    respond_to do |format|
      format.js
    end
  end


  def booking_complete
    @appointment = Appointment.find(params[:appointment_id])
  end


  private

  def practice_params
    params.require(:practice).permit(:name, :slug)
  end

end
