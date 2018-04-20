class AddNameInfoToInvitations < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :recipient_first_name, :text
    add_column :invitations, :recipient_last_name, :text
  end
end
