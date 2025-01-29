# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(
  username: 'admin',
  phone_number: '+1234567890',
  confirmed: true,
  active: true
)

folder = Folder.create!(
  user: user,
  name: 'My Folder',
  description: 'This is a folder'
)

component = Component.create!(
  folder: folder,
  price: 100,
  code: 1234567890,
  name: 'Component 1'
)
