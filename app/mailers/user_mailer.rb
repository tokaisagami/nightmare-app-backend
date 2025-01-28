class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def reset_password_email(user)
    @user = user
    @url  = edit_api_v1_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: 'Your password has been reset')
  end
end
