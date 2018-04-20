class AddPaymentStatusToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :paid, :boolean
  end
end
