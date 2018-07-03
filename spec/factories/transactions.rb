FactoryBot.define do
  factory :transaction do

    # sequence :current_user_transactions do |n|
    #   description "currentUserTransaction#{n}"
    #   user :current_user
    #   transaction_date Date.today
    #   amount n
    # end
    # after(:create) do | user, evaluator |
    #   create :transaction, user: user, description: "currentUserTransaction1", transaction_date: Date.today, amount: 1
    #   create :transaction, user: user, description: "currentUserTransaction2", transaction_date: Date.yesterday, amount: 2
    #   create :budgeted_line_item, user: user, description: "budgetitem1", amount: -1.1, recurrence: "monthly", recurrence_multiplier: 1
    #   create :budgeted_line_item, user: user, description: "budgetitem2", amount: 2.1, recurrence: "weekly", recurrence_multiplier: 1
    # end
  end
end
