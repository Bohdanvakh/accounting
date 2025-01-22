class User < ApplicationRecord
  require 'jwt'

  include JwtHelper
  include UserConfirmation
  include PhoneConfirmation
  include UsernameGenerator

  before_validation :set_username

  has_many :folders, dependent: :destroy
  has_many :components, through: :folder

  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true
end
