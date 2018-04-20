class Complaint < ApplicationRecord
  has_many :users, through: :user_complaints
  has_many :user_complaints
end
