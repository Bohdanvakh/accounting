class Dimension < ApplicationRecord
  # Associations
  belongs_to :component

  # Validations
  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
  validates :measurement, presence: true, inclusion: { in: %w(cm in), message: "%{value} is not a valid measurement" }
end
