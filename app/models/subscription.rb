class Subscription < ApplicationRecord
  belongs_to :user
  after_initialize :init
  PLANS = [["patient","Free"],["basic", "$39/mo"], ["enterprise", "$129/mo"]]

  def init
    self.plan ||= "Patient"
    self.valid_until = Time.now + 5.years if self.plan == "Patient"
  end

end
