class User < ApplicationRecord
  has_many :folders, dependent: :destroy
  has_many :components, through: :folder
end
