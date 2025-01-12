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
end

