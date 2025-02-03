class UserMailer < ApplicationMailer
  default from: 'no-reply@mg.nightmare-app.com'

  def reset_password_email(user)
    @user = user
    frontend_url = ENV['FRONTEND_URL']
    @url = "#{frontend_url}/password-reset?token=#{user.reset_password_token}"
    mail(to: @user.email, subject: 'Your password has been reset')
  end
end
