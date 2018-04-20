class AddStatusToRelationship < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :status, :integer
  end
end
