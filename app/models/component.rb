class Component < ApplicationRecord
  # Callbacks
  before_save :set_code

  # Include concerns
  include ComponentMethods
  include Searchable

  # Scopes
  include_searchable_scopes :by_name, :by_code # includes scopes we want to use

  # Associations
  belongs_to :folder
  has_one :user, through: :folder
  has_one :image, as: :imageable
  has_one :dimension, dependent: :destroy

  # Validations
  validates :price, presence: true
  validates :currency, presence: true
  validates :name, presence: true, length: { maximum: 120 }
  validates :weight, presence: true
  validates :measurement, presence: true, inclusion: { in: %w(kg lb), message: "%{value} is not a valid measurement" }

  # Methods
  private

  def set_code
    self.code = "C_#{DateTime.now.to_i}_F#{folder_id}"
  end
end
