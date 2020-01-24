FactoryBot.define do
  factory :event do
    name { "MyString" }
    date { "2020-02-20" }
    attendees { 5 }
    :user
  end
end
