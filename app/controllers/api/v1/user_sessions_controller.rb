module Api
  module V1
    class UserSessionsController < ApplicationController
      skip_before_action :require_login, only: [:create]

      def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          render json: { message: 'Login successful', user: user }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
