class AddDescriptionToToDoItem < ActiveRecord::Migration[5.0]
  def change
    add_column :todo_items, :description, :text
    rename_column :todo_items, :content, :title
  end
end
