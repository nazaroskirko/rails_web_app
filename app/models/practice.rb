class Practice < ApplicationRecord
  has_many :practice_doctors
  has_many :doctors, through: :practice_doctors
  validates :name, presence: true, length: {maximum: 50, minimum: 4}
  validates :slug, uniqueness: { case_sensitive: false }
  before_create :ensure_slug_present




  private


  def ensure_slug_present
    self.slug ||= name.parameterize
  end



end
