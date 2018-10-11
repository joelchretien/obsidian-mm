FactoryBot.define do
  factory :budgeted_line_item do
    sequence(:description) { |n| "BudgetedLineItem#{n}" }
    sequence(:amount) { |n| Money.new(n) }
    recurrence 0
    recurrence_multiplier 1
    start_date DateTime.now.beginning_of_day
    account
  end
end
