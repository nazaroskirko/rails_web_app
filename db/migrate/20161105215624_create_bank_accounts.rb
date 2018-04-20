class CreateBankAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :bank_accounts do |t|
      t.integer :user_id
      t.string :stripe_token

      t.timestamps
    end
  end
end
