FactoryBot.define do
  factory :contact do
    association(:user, factory: :user)
    full_name { "MyString" }
    organisation { "MyString" }
    notes { "MyText" }
    email_primary { "primary@email.com" }
    label_email_primary { "personal" }
    email_secondary { "secondary@email.com" }
    label_email_secondary { "work" }
    phone_primary { "778-5555-555" }
    label_phone_primary { "personal" }
    phone_secondary { "604-5555-555" }
    label_phone_secondary { "work" }
  end
end
