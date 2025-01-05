class User < ApplicationRecord
  has_many :folders
  has_many :components, through: :folder
end
