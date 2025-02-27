class CleanUpPhoneNumbers < ActiveRecord::Migration[7.1]
  def change
    User.find_each do |user|
      cleaned_phone_number = user.phone_number.gsub(/[^+\d]/, '')
      user.update_column(:phone_number, cleaned_phone_number)
    end
  end
end
