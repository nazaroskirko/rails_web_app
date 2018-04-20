class RelationshipsController < ApplicationController
  before_action :logged_in_user
  def new
    @relationship = Relationship.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @relationship = Relationship.new(relationship_params)
    @response = @relationship.save
    respond_to do |format|
      format.js
    end
  end

  def confirm
      @relationship = Relationship.find_by(token: params[:relationship_token])
      @doctor = User.find(@relationship.doctor_id)
      @id = @relationship.id
    end

  def patient_decision
      @relationship = Relationship.find_by(token: params[:relationship_token])
      @relationship.update_attribute(:status, params[:status])
      if @relationship.status == "confirmed"
        flash[:success] = "You can now book appointments with your therapist!"
        ReminderMailer.patient_accepted(@relationship).deliver
        redirect_to user_path(User.find(@relationship.doctor_id))
      else
        flash[:warning] = "You have denied your relationship with Dr. #{User.find(@relationship.doctor_id).last_name}."
        ReminderMailer.patient_declined(@relationship).deliver
        redirect_to @user
      end
    end


  def update
    @relationship = Relationship.find(params[:id])
    @relationship.update_attributes(relationship_params)
    @patient = User.find(@relationship.patient_id)
    ReminderMailer.connection(@relationship, relationships_add_patient_url(@relationship.token)).deliver
    respond_to do |format|
      format.js
    end
  end

  def reconfirm_relationship
    @relationship = Relationship.find_by("patient_id = ? AND doctor_id = ?", params[:patient_id], params[:doctor_id])
    ReminderMailer.connection(@relationship, relationships_add_patient_url(@relationship.token)).deliver
    respond_to do |format|
      format.js
    end
  end

  def confirm_relationship
    @relationship = Relationship.find_by("patient_id = ? AND doctor_id = ?", params[:patient_id], params[:doctor_id])
    @relationship.status = "confirmed"
    @relationship.save
    respond_to do |format|
      format.js
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:doctor_id,:patient_id,:status)
  end

end
