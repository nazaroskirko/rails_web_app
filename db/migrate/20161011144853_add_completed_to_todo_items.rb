class AddCompletedToTodoItems < ActiveRecord::Migration[5.0]
  def change
    add_column :todo_items, :completed, :boolean, default:false, null:false
  end
end
