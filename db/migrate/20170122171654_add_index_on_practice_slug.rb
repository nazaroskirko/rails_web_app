class AddIndexOnPracticeSlug < ActiveRecord::Migration[5.0]
  def change
    add_index :practices, :slug
  end
end
