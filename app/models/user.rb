class User < ApplicationRecord
  require 'jwt'

  has_many :folders, dependent: :destroy
  has_many :components, through: :folder

  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true

  def generate_jwt_token
    payload = { user_id: id, exp: 30.days.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def set_phone_confirmation_token
    self.update!(phone_confirmation_token: generate_confirmation_token, token_sent_at: Time.now)
  end

  def token_not_expired?
    token_sent_at + 10.minutes > Time.now
  end

  def confirm_phone(confirmation_code)
    if token_not_expired?
      if phone_confirmation_token == confirmation_code
        self.update!(phone_confirmation_token: nil, token_sent_at: nil)
        { success: true, message: 'User was confirmed.' }
      else
        { success: false, error: 'Wrong confirmation code.' }
      end
    end
  end

  def set_user_confirmed(confirmation_code)
    if phone_confirmation_token == confirmation_code
      self.update!(phone_confirmation_token: nil, token_sent_at: nil, confirmed: true)
      { success: true, message: 'User was confirmed' }
    else
      { success: false, error: 'Wrong confirmation code' }
    end
  end

  private

  def generate_confirmation_token
    SecureRandom.random_number(1_000_000).to_s.rjust(6, '0')
  end
end

