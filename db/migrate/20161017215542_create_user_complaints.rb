class CreateUserComplaints < ActiveRecord::Migration[5.0]
  def change
    create_table :user_complaints do |t|
      t.integer :user_id
      t.integer :complaint_id
      t.date :start
      t.date :end
      t.boolean :repeat_experience

      t.timestamps
    end
  end
end
