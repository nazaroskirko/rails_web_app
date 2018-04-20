class UpdateMessages < ActiveRecord::Migration[5.0]
  def change
    change_table :messages do |t|
      t.references :conversation, index: true
      t.references :user, index: true
    end
    add_column :messages,  :read, :boolean,  default: false
  end
end
