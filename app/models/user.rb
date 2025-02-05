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

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
end
