module Api
  module V1
    class UserSessionsController < ApplicationController
      skip_before_action :require_login, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          secret_key_base = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE']
          token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, secret_key_base, 'HS256')
          render json: { message: 'Login successful', token: token, user_name: user.name, user_email: user.email }, status: :created
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
