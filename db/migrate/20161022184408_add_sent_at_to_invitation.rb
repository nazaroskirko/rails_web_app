class AddSentAtToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :sent_at, :datetime
  end
end
