class CreatePracticeDoctors < ActiveRecord::Migration[5.0]
  def change
    create_table :practice_doctors do |t|
      t.integer :practice_id
      t.integer :doctor_id

      t.timestamps
    end
  end
end
