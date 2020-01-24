require "rails_helper"

RSpec.describe Contact, type: :model do
  describe "validations" do
    it "has a name" do
      user = FactoryBot.create(:user)
      contact = FactoryBot.build(:contact, full_name: nil, user_id: user.id)
      contact.valid?
      expect(contact.errors.messages).to have_key :full_name
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

  describe "::search" do
    before do
      @user = FactoryBot.create(:user)
      @contact1 = FactoryBot.create(
        :contact,
        full_name: "gamma zoli 123",
        email_primary: "gamma@zoli.com",
        email_secondary: "secondary@zoli.com",
        phone_primary: "555-777-1111",
        phone_secondary: "111-222-4444",
        organisation: "Small Firm",
        notes: "has lot's of money",
        user_id: @user.id,
      )
      @contact2 = FactoryBot.create(
        :contact,
        full_name: "alpha bela 234",
        email_primary: "alpha@bela.com",
        email_secondary: "secondary@bela.com",
        phone_primary: "555-666-7777",
        phone_secondary: "111-222-3333",
        organisation: "Big Firm",
        notes: "haven't seen in a while",
        user_id: @user.id,
      )
      @contact3 = FactoryBot.create(
        :contact,
        full_name: "beta joska 345",
        email_primary: "beta@joska.com",
        email_secondary: "secondary@joska.com",
        phone_primary: "555-666-8888",
        phone_secondary: "111-222-4444",
        organisation: "Big Company",
        notes: "owes me money",
        user_id: @user.id,
      )
    end

    it "returns the result in alphabetical order" do
      contacts = Contact.search("a")
      expect(contacts).to eq([@contact2, @contact3, @contact1])
    end

    it "returns all contacts of the user for empty search phrase" do
      contacts = Contact.search()
      expect(contacts).to eq([@contact2, @contact3, @contact1])
    end

    it "searches by full_name" do
      contacts = Contact.search("23")
      expect(contacts).to eq([@contact2, @contact1])
    end

    it "searches by phone number" do
      contacts = Contact.search("666")
      expect(contacts).to eq([@contact2, @contact3])
      contacts = Contact.search("444")
      expect(contacts).to eq([@contact3, @contact1])
    end

    it "searches by email" do
      contacts = Contact.search("@bela")
      expect(contacts).to eq([@contact2])
      contacts = Contact.search("secondary@zoli.com")
      expect(contacts).to eq([@contact1])
    end
    
    it "searches by organisation" do
      contacts = Contact.search("Firm")
      expect(contacts).to eq([@contact2, @contact1])
    end
    
    it "searches in the notes" do
      contacts = Contact.search("money")
      expect(contacts).to eq([@contact3, @contact1])
    end
  end
end
