class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :stripe_token
      t.string :plan
      t.datetime :valid_until

      t.timestamps
    end
  end
end
