class AddTokentoRelationship < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :token, :string
  end
end
