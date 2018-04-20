class UserComplaint < ApplicationRecord
  belongs_to :user
  belongs_to :complaint
end
