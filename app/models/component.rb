class Component < ApplicationRecord
  # Include concerns
  include ComponentMethods

  # Associations
  belongs_to :folder
  has_one :user, through: :folder
  has_one :dimension, dependent: :destroy

  # Validations
  validates :price, presence: true
  validates :currency, presence: true
  validates :name, presence: true, length: { maximum: 120 }
  validates :weight, presence: true
  validates :measurement, presence: true
end
