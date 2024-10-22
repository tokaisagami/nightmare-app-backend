class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :require_login

  private

  def require_login
    authenticate_token || not_authenticated
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      puts "Received token: #{token}" # トークンをログに出力
      secret_key = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE']
      begin
        puts "ペイロードとヘッダー取得開始" # トークンをログに出力
        payload, header = JWT.decode(token, Rails.application.credentials.secret_key_base)
        puts "ペイロードとヘッダー取得成功" # トークンをログに出力
        puts "Payload: #{payload.inspect}"
        puts "Header: #{header.inspect}"
        @current_user = User.find_by(id: payload['user_id'])
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def not_authenticated
    render json: { error: "You need to log in to access this resource" }, status: :unauthorized
  end
end
