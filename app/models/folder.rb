class Folder < ApplicationRecord
  # Callbacks
  before_save :set_code

  # Include concerns
  include FolderMethods

  # Associations
  belongs_to :user
  has_many :components, dependent: :destroy

  # Scopes
  scope :by_name, ->(name) { where("name = ?", name) }
  scope :by_code, ->(code) { where("code = ?", code) }

  # Validations
  validates :name, presence: true, length: {minimum:6, maximum:120}, format: {with: /[a-zA-Z]/}

  # Methods
  def area
    FolderAreaCalculator.new(self).calculate
  end

  def weight
    FolderWeightCalculator.new(self).calculate
  end

  def set_code
    self.code = "F_#{DateTime.now.to_i}_U#{user_id}"
  end
end
