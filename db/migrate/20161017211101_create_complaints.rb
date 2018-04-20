class CreateComplaints < ActiveRecord::Migration[5.0]
  def change
    create_table :complaints do |t|
      t.integer :user_id
      t.text :description
      t.date :start
      t.boolean :repeat_experience
      t.date :end

      t.timestamps
    end
  end
end
