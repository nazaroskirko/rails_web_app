require 'test_helper'

class ReminderMailerTest < ActionMailer::TestCase
  test "connection" do
    mail = ReminderMailer.connection
    assert_equal "Connection", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "appointment" do
    mail = ReminderMailer.appointment
    assert_equal "Appointment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "session" do
    mail = ReminderMailer.session
    assert_equal "Session", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
