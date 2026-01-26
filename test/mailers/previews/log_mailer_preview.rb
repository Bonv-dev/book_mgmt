# Preview all emails at http://localhost:3000/rails/mailers/log_mailer
class LogMailerPreview < ActionMailer::Preview
  def change_status_email
    new_log   = Log.where(book_id: 1, status: 2).first
    old_log   = Log.where(book_id: 1, status: 1).first
    from_user = User.where(is_librarian: true).first
    to_users  = User.limit(2)

    LogMailer.change_status_email(new_log, old_log, from_user, to_users)
  end
end
