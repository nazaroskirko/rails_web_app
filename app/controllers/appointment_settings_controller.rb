class AppointmentSettingsController < ApplicationController

  def update
    @setting = AppointmentSetting.find(params[:id])
    @setting.update_attributes(setting_params)
    respond_to do |format|
      format.js
    end
  end

    private
    def setting_params
      params.require(:appointment_setting).permit(:user_id, :billing_rate)
    end
end
