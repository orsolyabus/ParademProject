require "rails_helper"

RSpec.describe Contact, type: :model do
  describe "validations" do
    it "has a name" do
      user = FactoryBot.create(:user)
      contact = FactoryBot.build(:contact, name: nil, user_id: user.id)
      contact.valid?
      expect(contact.errors.messages).to have_key :name
    end

    it "belong to a user" do
      contact = FactoryBot.build(:contact, user_id: nil)
      contact.valid?
      expect(contact.errors.messages).to have_key :user
    end

    it "email addresses are valid emails" do
      contact = FactoryBot.build(:contact, email_primary: "wrongEmail", email_secondary: "wrongEmail")
      contact.valid?
      expect(contact.errors.messages).to have_key :email_primary
      expect(contact.errors.messages).to have_key :email_secondary
    end
  end
end
