class AddPrimaryPhoneToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :primary_phone, :string
  end
end
