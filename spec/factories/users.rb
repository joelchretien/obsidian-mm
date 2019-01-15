FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    confirmed_at { Time.now }
    password { "userPassword" }
  end
end
