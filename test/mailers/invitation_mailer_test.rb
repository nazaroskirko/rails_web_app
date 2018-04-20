require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "patient" do
    mail = InvitationMailer.patient
    assert_equal "Patient", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
