FactoryBot.define do
  sequence(:description) do |n|
    "Transaction#{n}"
  end

  sequence(:amount) do |n|
    Money.from_amount(n)
  end

  sequence(:transaction_date) do |n|
    Date.today + n.day
  end

  sequence(:balance) do |n|
    Money.from_amount(n)
  end

  factory :transaction do
    description
    amount
    transaction_date
    account
    imported_file
    balance
  end
end
