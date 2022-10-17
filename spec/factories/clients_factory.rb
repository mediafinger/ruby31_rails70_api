FactoryBot.define do
  factory :client do
    email { Faker::Internet.email(domain: "example.com") }
    password { "foobar1234" }
    name { Faker::Name.name }
  end
end
