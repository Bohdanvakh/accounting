class Folder < ApplicationRecord
  # Callbacks
  before_save :set_code

  # Include concerns
  include FolderMethods
  include Searchable

  # Associations
  belongs_to :user
  has_many :components, dependent: :destroy

  # Scopes
  include_searchable_scopes :by_name, :by_code # includes scopes we want to use
  scope :lower_price, -> { joins(:components).group('folders.id')
                                             .select('folders.*, SUM(components.price) AS total_price')
                                             .order('total_price ASC') }
  scope :higher_price, -> { joins(:components).group('folders.id')
                                             .select('folders.*, SUM(components.price) AS total_price')
                                             .order('total_price DESC') }

  # Validations
  validates :name, presence: true, length: {minimum:6, maximum:120}, format: {with: /[a-zA-Z]/}

  # Methods
  def area
    FolderAreaCalculator.new(self).calculate
  end

  def weight
    FolderWeightCalculator.new(self).calculate
  end

  def components_price_sum
    components.map(&:price).sum
  end

  private

  def set_code
    self.code = "F_#{DateTime.now.to_i}_U#{user_id}"
  end
end
