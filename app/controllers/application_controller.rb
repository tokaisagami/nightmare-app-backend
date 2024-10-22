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
        payload, header = JWT.decode(token, secret_key)
        puts "Payload: #{payload}" # ペイロードの内容をログに出力
        user_id = payload['user_id']
        @current_user = User.find_by(id: user_id)
        if @current_user
          puts "Current User: #{@current_user.inspect}" # ユーザーをログに出力
        else
          puts "User not found for ID: #{user_id}" # ユーザーが見つからない場合
        end
      rescue JWT::DecodeError => e
        puts "JWT Decode Error: #{e.message}" # デコードエラーをログに出力
        nil
      end
    end
  end

  def not_authenticated
    render json: { error: "You need to log in to access this resource" }, status: :unauthorized
  end
end
