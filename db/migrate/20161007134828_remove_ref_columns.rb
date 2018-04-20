class RemoveRefColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :todo_lists, :user_id
    remove_column :todo_items, :todo_list_id
  end
end
