class AddLicensenoToBankAccounts < ActiveRecord::Migration[5.0]
  def change
  	add_column :bank_accounts, :license_number, :integer
  end
end
