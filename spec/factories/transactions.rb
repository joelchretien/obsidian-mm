FactoryBot.define do
  factory :transaction do

    transaction_date Date.today
    factory :current_user_transactions do
      sequence(:description) do |n|
        "currentUserTransaction#{n}"
      end
      sequence(:amount) do |n|
        Money.new(n)
      end
      association :user, factory: :current_user
    end
  end
end
