require "test_helper"

class LogMailerTest < ActionMailer::TestCase
  test "change_status_email" do
    new_log  = logs(:new_log)
    old_log  = logs(:old_log)
    from_user = users(:librarian)
    to_users  = [ users(:one), users(:two) ]

    mail = LogMailer.change_status_email(new_log, old_log, from_user, to_users)

    assert_equal "蔵書のステータス変更", mail.subject
    assert_equal [ from_user.email ], mail.from
    assert_equal to_users.map(&:email), mail.to.sort

    body = mail.text_part.body.to_s
    assert_includes body, "司書名：#{from_user.name}"
    assert_includes body, "蔵書名：#{new_log.book.name}"
    assert_includes body, "変更"
  end
end
