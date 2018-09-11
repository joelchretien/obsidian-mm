FactoryBot.define do
  sequence(:description) do |n|
    "Transaction#{n}"
  end

  sequence(:amount) do |n|
    Money.new(n)
  end

  sequence(:transaction_date) do |n|
    Date.today + n.day
  end

  factory :transaction do
    description
    amount
    transaction_date
  end
end
