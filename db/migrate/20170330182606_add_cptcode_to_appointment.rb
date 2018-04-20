class AddCptcodeToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :cpt_code, :integer
  end
end
