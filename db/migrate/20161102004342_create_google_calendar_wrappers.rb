class CreateGoogleCalendarWrappers < ActiveRecord::Migration[5.0]
  def change
    create_table :google_calendar_wrappers do |t|

      t.timestamps
    end
  end
end
