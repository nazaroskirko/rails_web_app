class Lead < ApplicationRecord
  serialize :groups
  serialize :anonymous_id
  validates :email, presence: {message: "Looks like you forgot to include your email!"}
  validates :first_name, presence: {message: "I like to be on a first name basis with potential clients.  Do you mind adding your first name?"}
  has_many :inquiries, :inverse_of => :lead
  accepts_nested_attributes_for :inquiries


  def self.send_notification_emails lead
    LeadNotifierMailer.send_home_form_email(lead).deliver
    LeadNotifierMailer.send_home_form_internal_notification(lead).deliver
  end

end
