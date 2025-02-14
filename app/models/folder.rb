class Folder < ApplicationRecord
  # Constants
  LBS_TO_KG = 0.453592

  # Include concerns
  include FolderMethods

  # Associations
  belongs_to :user
  has_many :components, dependent: :destroy

  # Validations
  validates :name, presence: true, length: {minimum:6, maximum:120}, format: {with: /[a-zA-Z]/}

  # Methods
  def weight
    weight = 0
    components.map do |component|
      component.measurement == "kg" ? weight += component.weight : weight += component.weight * LBS_TO_KG
    end
    weight
  end
end
