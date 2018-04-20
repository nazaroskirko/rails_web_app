class Changedates < ActiveRecord::Migration[5.0]
  def change
    remove_column :profiles, :marriage_date
    remove_column :profiles, :divorced_date
  end
end
