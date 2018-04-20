class AddEventTypeToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :event_type, :integer
  end
end
