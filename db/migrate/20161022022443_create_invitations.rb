class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.string :sender_id
      t.string :recipient_email
      t.string :token

      t.timestamps
    end
  end
end
