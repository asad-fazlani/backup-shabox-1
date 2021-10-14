require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "shadbox_notification" do
    mail = UserMailer.shadbox_notification
    assert_equal "Shadbox notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
