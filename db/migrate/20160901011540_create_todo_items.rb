class CreateTodoItems < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_items do |t|
      t.string :content
      t.references :todo_list, foreign_key: true
      t.datetime :deadline

      t.timestamps
    end
  end
end
