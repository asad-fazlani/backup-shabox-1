# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/shadbox_notification
  def shadbox_notification
    UserMailer.shadbox_notification
  end

end
