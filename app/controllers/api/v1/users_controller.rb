module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :require_login, only: [:create]

      def create
        @user = User.new(user_params)
        if @user.save
          render json: { message: 'User created successfully' }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        user = User.find(params[:id])
        nightmares = user.nightmares.order(created_at: :desc) # すべてのナイトメアを作成日時の降順で取得
        render json: { name: user.name, email: user.email, nightmares: nightmares }
      end

      def update
        user = User.find(params[:id])
        if user.update(user_params)
          render json: { message: 'User updated successfully' }, status: :ok
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
