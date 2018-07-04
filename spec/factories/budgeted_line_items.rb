FactoryBot.define do
  factory :budgeted_line_item do
    description "MyText"
    amount 1.5
    recurrence 0
    recurrence_multiplier 1
    start_date DateTime.now.beginning_of_day
    association :user, factory: :current_user
    factory :current_user_bugeted_line_items do
      sequence(:description) do |n|
        "BudgetedLineItem#{n}"
      end
      sequence(:amount) do |n|
        Money.new(n)
      end
    end
  end
end
