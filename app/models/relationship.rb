class Relationship < ApplicationRecord
  belongs_to :doctor, class_name: "User"
  belongs_to :patient, class_name: "User"
  enum status: [:patient_requested, :doctor_requested, :confirmed, :patient_cancelled, :doctor_cancelled]
  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, self.patient_id,self.doctor_id].join)
  end
end
