class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue
    render json: { error: "unauthorized" }, status: :unauthorized
  end
end
