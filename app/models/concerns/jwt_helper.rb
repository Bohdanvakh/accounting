module JwtHelper
  def generate_jwt_token
    payload = { user_id: id, exp: 30.days.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
