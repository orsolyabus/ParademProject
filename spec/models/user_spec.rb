require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "has a name" do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors.messages).to have_key :name
    end
    it "has valid email" do
      user1 = FactoryBot.build(:user, email: nil)
      user1.valid?
      user2 = FactoryBot.build(:user, email: "wrongEmail")
      user2.valid?
      expect(user1.errors.messages).to have_key :email
      expect(user2.errors.messages).to have_key :email
    end
    it "has unique email" do
      user1 = FactoryBot.create(:user, email: "this@email.com")
      user2 = FactoryBot.build(:user, email: "this@email.com")
      user2.valid?
      expect(user2.errors.messages).to have_key :email
    end
    it "has password" do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors.messages).to have_key :password
    end
  end
end
