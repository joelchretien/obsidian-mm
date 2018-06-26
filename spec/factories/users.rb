FactoryBot.define do

  factory :user do
    confirmed_at Time.now

    factory :current_user do
      email "user@example.com"
      password "userPassword"
      after(:create) do | user, evaluator |
        create :transaction, user: user, description: "currentUserTransaction1", transaction_date: Date.today, amount: 1
        create :transaction, user: user, description: "currentUserTransaction2", transaction_date: Date.yesterday, amount: 2
      end
    end
    factory :other_user do
      email "other_user@example.com"
      password "other_userPassword"
      after(:create) do | user, evaluator |
        create :transaction, user: user, description: "otherUserTransaction1", transaction_date: Date.today, amount: -1
        create :transaction, user: user, description: "otherUserTransaction2", transaction_date: Date.yesterday, amount: -2
      end
    end
  end
end
