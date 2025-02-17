class Folder < ApplicationRecord
  # Include concerns
  include FolderMethods

  # Associations
  belongs_to :user
  has_many :components, dependent: :destroy

  # Validations
  validates :name, presence: true, length: {minimum:6, maximum:120}, format: {with: /[a-zA-Z]/}

  # Methods
  def area
    FolderAreaCalculator.new(self).calculate
  end

  def weight
    FolderWeightCalculator.new(self).calculate
  end
end
