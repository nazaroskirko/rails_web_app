class FormatAppointmentDates < ActiveRecord::Migration[5.0]
  def change
    change_column :appointments, :start, :time
    change_column :appointments, :end, :time
    add_column :appointments, :date, :date

  end
end
