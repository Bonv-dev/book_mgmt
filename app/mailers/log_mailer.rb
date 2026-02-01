class LogMailer < ApplicationMailer
  def change_status_email(new_log, old_log, from_user, to_users)
    @book = new_log.book
    @new_status = new_log.status
    @old_status = old_log.status
    @from_user = from_user
    mail(
      to: to_users.map { |u| u.email }.join("; "),
      from: @from_user.email,
      subject: "蔵書のステータス変更"
    )
  end
end
