# Command to run rails seeds to create data in your db: bin/rails db:seed
# In this file we create basic data for our application db.
# If you want to extend data, create new instance objects etc please create separate seeds file
# for that. For example: db/seeds/new_file.rb.
# And run new files as: bin/rails db:seed:new_file

unless Rails.env.production?
  users = 100.times.map do
    User.create!(
      username: Faker::Name.name,
      phone_number: Faker::PhoneNumber.phone_number_with_country_code,
      confirmed: true,
      active: true
    )
  end

  folders = users.flat_map do |user|
    30.times.map do
      Folder.create!(
        user: user,
        name: "#{Faker::Name.name} folder"
      )
    end
  end

  components = folders.flat_map do |folder|
    20.times.map do
      Component.create!(
        folder: folder,
        price: rand(10..320),
        code: "#{rand(10**9..10**10-1)}",
        name: "#{Faker::Name.name} component",
        weight: rand(0..99),
        measurement: ['lb', 'kg'].sample,
        currency: 'USD'
      )
    end
  end

  components.each do |component|
    Dimension.create!(
      component: component,
      length: rand(0..500),
      width: rand(0..500),
      height: rand(0..500),
      measurement: ['cm', 'in'].sample
    )
  end
end
