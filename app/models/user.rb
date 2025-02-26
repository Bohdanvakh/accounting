class User < ApplicationRecord
  require 'jwt'

  # Include concerns
  include JwtHelper
  include UserConfirmation
  include PhoneConfirmation
  include UsernameGenerator

  # Callbacks
  before_validation :set_username

  # Associations
  has_many :folders, dependent: :destroy
  has_many :components, through: :folder
  has_one :image, as: :imageable

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+?\d+\z/, message: "only allows + and numbers" }

  def detailed_info
    {
      id: id,
      username: username,
      phone_number: phone_number,
      image_url: image.url
    }
  end
end
