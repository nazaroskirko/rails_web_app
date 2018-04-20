class AddProfileInformation < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :dob, :date
    add_column :profiles, :phone, :string
    add_column :profiles, :primary_physician, :string
    add_column :profiles, :primary_physicion_phone, :string
    add_column :profiles, :current_therapist, :string
    add_column :profiles, :therapist_phone, :string
    add_column :profiles, :sex, :string
    add_column :profiles, :exercise_frequency, :text
    add_column :profiles, :exercise_types, :string
    add_column :profiles, :allergies, :text
    add_column :profiles, :current_medications, :text
    add_column :profiles, :diagnoses, :text
    add_column :profiles, :past_medications, :text
    add_column :profiles, :med_conditions, :text
    add_column :profiles, :surgeries, :text
    add_column :profiles, :past_physicians, :text
    add_column :profiles, :dates_treate, :text
    add_column :profiles, :adopted, :boolean
    add_column :profiles, :adopted_age, :string
    add_column :profiles, :mother_rel, :text
    add_column :profiles, :father_rel, :text
    add_column :profiles, :siblings_and_ages, :text
    add_column :profiles, :married, :string
    add_column :profiles, :divorced, :string
    add_column :profiles, :d_age, :string
    add_column :profiles, :remarry, :string
    add_column :profiles, :remarry_age, :string
    add_column :profiles, :caretaker, :string
    add_column :profiles, :home_location, :string
    add_column :profiles, :family_med, :text
    add_column :profiles, :family_mental, :text
    add_column :profiles, :family_treatments, :text
    add_column :profiles, :move, :text
    add_column :profiles, :independence, :text
    add_column :profiles, :family_death, :text
    add_column :profiles, :suicide, :text
    add_column :profiles, :neglect, :text
    add_column :profiles, :trauma, :text
    add_column :profiles, :abuse, :text
    add_column :profiles, :education, :text
    add_column :profiles, :ed_date, :string
    add_column :profiles, :ed_location, :string
    add_column :profiles, :military, :string
    add_column :profiles, :military_location, :text
    add_column :profiles, :military_dates, :text
    add_column :profiles, :rank, :string
    add_column :profiles, :work_status, :string
    add_column :profiles, :marriage_date, :string
    add_column :profiles, :divorced_date, :string
    add_column :profiles, :marriage_count, :string
    add_column :profiles, :children, :text
    add_column :profiles, :child_birthdays, :text
    add_column :profiles, :child_relationship, :text
    add_column :profiles, :living_situation, :text
    add_column :profiles, :arrested, :boolean
    add_column :profiles, :arrested_details, :text



  end
end
