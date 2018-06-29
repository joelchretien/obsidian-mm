FactoryBot.define do
  factory :budgeted_line_item do
    description "MyText"
    amount 1.5
    recurrence 0
    recurrence_multiplier ""
    association :user, factory: :current_user
  end
end
