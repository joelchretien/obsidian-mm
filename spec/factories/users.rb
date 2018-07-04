FactoryBot.define do

  factory :user do
    confirmed_at Time.now

    factory :current_user do
      email "user@example.com"
      password "userPassword"
    end
    factory :other_user do
      email "other_user@example.com"
      password "other_userPassword"
    end
  end
end
