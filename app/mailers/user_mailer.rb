class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def reset_password_email(user)
    @user = user
    @url  = "http://localhost:5173/password-reset?token=#{user.reset_password_token}"
    mail(to: @user.email, subject: 'Your password has been reset')
  end
end
