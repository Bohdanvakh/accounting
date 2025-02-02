class Dimension < ApplicationRecord
  belongs_to :component

  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
end
