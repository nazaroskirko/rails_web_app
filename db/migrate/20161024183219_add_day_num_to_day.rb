class AddDayNumToDay < ActiveRecord::Migration[5.0]
  def change
    add_column :days, :day_num, :integer
  end
end
