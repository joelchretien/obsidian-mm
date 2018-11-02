FactoryBot.define do
  factory :budgeted_line_item do
    sequence(:description) { |n| "BudgetedLineItem#{n}" }
    sequence(:amount) { |n| Money.from_amount(n) }
    recurrence 0
    recurrence_multiplier 1
    start_date Date.today
    account
  end
end
