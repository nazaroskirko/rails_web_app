class AddTodoListToTodoItems < ActiveRecord::Migration[5.0]
  def change
    add_reference :todo_items, :todo_list, foreign_key: true
  end
end
