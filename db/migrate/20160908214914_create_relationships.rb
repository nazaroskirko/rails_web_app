class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :doctor_id
      t.integer :patient_id

      t.timestamps
    end

    add_index :relationships, :doctor_id
    add_index :relationships, :patient_id
    add_index :relationships, [:doctor_id, :patient_id], unique: true
  end
end
