class AddCalendarSyncTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :next_goog_cal_sync_token, :text
  end
end
