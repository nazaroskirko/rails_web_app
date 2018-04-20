class Invitation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  has_one :recipient, class_name: "User"

  validates_presence_of :recipient_email
  validates_presence_of :recipient_first_name
  validate :recipient_is_not_registered
  validate :sender_has_invitations, if: :sender

  before_create :generate_token
  before_create :decrement_sender_count, if: :sender

  private

  def recipient_is_not_registered
    errors.add :recipient_email, 'is already registered' if User.find_by(email: recipient_email)
  end

  def sender_has_invitations
    unless sender.invitation_limit > 0
      errors.add_to_base 'You have reached the maximum number of patient invitations for your plan.'
    end
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def decrement_sender_count
    sender.decrement! :invitation_limit
  end
end
