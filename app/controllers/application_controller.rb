class ApplicationController < ActionController::API
  before_action :require_login

  private

  def not_authenticated
    render json: { error: "You need to log in to access this resource" }, status: :unauthorized
  end
end
