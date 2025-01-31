module Api
  module V1
    class PasswordResetsController < ApplicationController
      skip_before_action :require_login, only: [:create, :edit, :update]

      def create
        @user = User.find_by_email(params[:email])
        if @user
          @user.deliver_reset_password_instructions!
          render json: { message: 'Instructions have been sent to your email.' }, status: :ok
        else
          render json: { error: 'Email address not found.' }, status: :not_found
        end
      end

      def edit
        @user = User.load_from_reset_password_token(params[:id])

        if @user.blank?
          render json: { error: "Invalid reset token" }, status: :unauthorized
        else
          render json: { message: "Valid token", user_id: @user.id }, status: :ok
        end
      end

      def update
        @token = params[:id]
        @user = User.load_from_reset_password_token(params[:id])

        unless @user
          render json: { error: "Invalid reset token" }, status: :unauthorized
          return
        end

        @user.password_confirmation = params[:password_reset][:password_confirmation]
        if @user.change_password(params[:password_reset][:password])
          render json: { message: 'Password was successfully updated.' }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
