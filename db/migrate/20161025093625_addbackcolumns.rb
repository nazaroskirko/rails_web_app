class Addbackcolumns < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :marriage_date, :datetime
    add_column :profiles, :divorced_date, :datetime
  end
end
