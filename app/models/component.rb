class Component < ApplicationRecord
  belongs_to :folder
  has_one :user, through: :folder
  has_one :dimention
end
