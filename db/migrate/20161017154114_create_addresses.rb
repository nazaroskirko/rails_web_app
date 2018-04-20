class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :number
      t.string :street
      t.string :apartment
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end