class CreatePractices < ActiveRecord::Migration[5.0]
  def change
    create_table :practices do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
