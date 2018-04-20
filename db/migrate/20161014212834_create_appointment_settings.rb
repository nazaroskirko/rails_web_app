class CreateAppointmentSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :appointment_settings do |t|
      t.integer :user_id
      t.string :time_zone
      t.time :booking_cutoff_time
      t.time :booking_cutoff_unit
      t.time :buffer_time
      t.time :day_start_time
      t.time :day_end_time
      t.float :billing_rate
      t.time :min_length
      t.time :max_length

      t.timestamps
    end
  end
end
