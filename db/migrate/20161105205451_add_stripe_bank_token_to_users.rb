class AddStripeBankTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_bank_token, :string
  end
end
