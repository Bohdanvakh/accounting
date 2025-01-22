require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "has a unique username" do
      user2 = build(:user, username: "testuser")
      expect(user2).to_not be_valid
    end

    it "has a unique phone number" do
      user2 = build(:user, phone_number: "+380672112460")
      expect(user2).to_not be_valid
    end
  end
end
