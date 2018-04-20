class PracticeDoctor < ApplicationRecord
  belongs_to :practice
  belongs_to :doctor, class_name: "User"
end
