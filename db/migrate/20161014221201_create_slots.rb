class CreateSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :slots do |t|
      t.integer :day_id
      t.time :start_time
      t.time :min_length
      t.time :max_length

      t.timestamps
    end
  end
end
