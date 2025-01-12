class ApplicationController < ActionController::API
  def authenticate!
    token = request.headers['Authorization']&.split(' ')&.last

    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        @current_user = User.find(decoded_token['user_id'])
      rescue JWT::DecodeError
        render json: { error: "Invalid or expired token" }, status: :unauthorized
      end
    else
      render json: { error: "Token missing" }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end
