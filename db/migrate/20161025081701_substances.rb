class Substances < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :alcohol, :boolean
    add_column :profiles, :heroin, :boolean
    add_column :profiles, :ecstasy, :boolean
    add_column :profiles, :tobacco, :boolean
    add_column :profiles, :methapmphetamines, :boolean
    add_column :profiles, :methadone, :boolean
    add_column :profiles, :marijuana, :boolean
    add_column :profiles, :cocaine, :boolean
    add_column :profiles, :tranquilizers, :boolean
    add_column :profiles, :lsd, :boolean
    add_column :profiles, :stimulants, :boolean
    add_column :profiles, :pain_killers, :boolean
    add_column :profiles, :caffeine, :boolean
    add_column :profiles, :prescription_drugs, :boolean

  end
end
