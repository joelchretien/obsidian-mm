FactoryBot.define do
  sequence(:description) do |n|
    "Transaction#{n}"
  end

  sequence(:amount) do |n|
    Money.new(n)
  end

  factory :transaction do
    description
    amount
    transaction_date Date.today
  end
end
