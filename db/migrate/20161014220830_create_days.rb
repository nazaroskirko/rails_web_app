class CreateDays < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |t|
      t.time :start
      t.time :end
      t.boolean :open
      t.text :schedule_type

      t.timestamps
    end
  end
end
