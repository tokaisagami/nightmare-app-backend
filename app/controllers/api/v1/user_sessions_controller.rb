module Api
  module V1
    class UserSessionsController < ApplicationController
      skip_before_action :require_login, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base)
          render json: { message: 'Login successful', token: token }, status: :created # トークンを返す
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
