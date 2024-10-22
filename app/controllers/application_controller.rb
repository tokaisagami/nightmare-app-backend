class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :require_login

  private

  def require_login
    authenticate_token || not_authenticated
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      puts "Received token: #{token}"
      secret_key = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE']
      begin
        payload, header = JWT.decode(token, secret_key, true, { algorithm: 'HS256' })
        puts "Payload: #{payload}"
        user_id = payload['user_id']
        @current_user = User.find_by(id: user_id)
        if @current_user
          puts "Current User: #{@current_user.inspect}"
        else
          puts "User not found for ID: #{user_id}"
        end
      rescue JWT::ExpiredSignature
        puts "Token has expired"
        render json: { error: 'Token has expired' }, status: :unauthorized
      rescue JWT::DecodeError => e
        puts "JWT Decode Error: #{e.message}"
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end
  end

  def not_authenticated
    render json: { error: "You need to log in to access this resource" }, status: :unauthorized
  end
end
