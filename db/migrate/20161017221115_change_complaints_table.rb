class ChangeComplaintsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :complaints, :user_id
    remove_column :complaints, :start
    remove_column :complaints, :end
    remove_column :complaints, :repeat_experience
    add_column :complaints, :name, :string

  end
end
