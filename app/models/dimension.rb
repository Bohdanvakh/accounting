class Dimension < ApplicationRecord
  # Associations
  belongs_to :component

  # Validations
  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
end
