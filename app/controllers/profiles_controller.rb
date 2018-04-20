class ProfilesController < ApplicationController

  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end

  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @profile.update_attributes(profile_params)
    respond_to do |format|
      format.js
    end
  end


private

  def profile_params
    params.require(:profile).permit(:user_id, :dob,:phone,:primary_physician,:primary_physicion_phone,:current_therapist,:therapist_phone,:sex,:exercise_frequency,:exercise_types,:allergies,:current_medications,:diagnoses,:past_medications,
    :med_conditions,:surgeries,:past_physicians,:dates_treate,:adopted,:adopted_age,:mother_rel,:father_rel,:siblings_and_ages,:married,:divorced,:d_age,
    :remarry,:remarry_age,:caretaker,:home_location,:family_med,:family_mental,:family_treatments,:move,:independence,:family_death,:suicide,:neglect,:trauma,:abuse,:education,:ed_date,:ed_location,:military,:military_location,:military_dates,
    :rank,:work_status,:marriage_date,:divorced_date,:marriage_count,:children,:child_birthdays,:child_relationship,:living_situation,:arrested,:arrested_details,:alcohol,:heroin,
    :ecstasy,:tobacco,:methapmphetamines,:methadone,:marijuana,:cocaine,:tranquilizers,:lsd,:stimulants,:pain_killers,:caffeine,:prescription_drugs)
  end
end
