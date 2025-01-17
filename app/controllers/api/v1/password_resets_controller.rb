module Api
  module V1
    class PasswordResetsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user
          user.deliver_reset_password_instructions!
        end
        render json: { message: "パスワードリセット手順を送信しました" }, status: :ok
      end

      def edit
        @user = User.load_from_reset_password_token(params[:id])
        if @user.blank?
          not_authenticated
          return
        end
      end

      def update
        @user = User.load_from_reset_password_token(params[:id])
        if @user.blank?
          not_authenticated
          return
        end

        if @user.change_password(params[:password])
          render json: { message: "パスワードをリセットしました" }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
