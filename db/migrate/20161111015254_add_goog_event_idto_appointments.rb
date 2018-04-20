class AddGoogEventIdtoAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :doctor_goog_event_id, :string
    add_column :appointments, :patient_goog_event_id, :string
  end
end
