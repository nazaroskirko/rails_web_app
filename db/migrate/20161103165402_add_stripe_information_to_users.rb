class AddStripeInformationToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :stripe_secret, :string
    add_column :users, :stripe_publishable, :string
  end
end
