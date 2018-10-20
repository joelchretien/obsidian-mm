def create_transaction_and_budget
  account = create :account
  transaction = build :transaction, account: account
  budgeted_line_item = build :budgeted_line_item,
    description: transaction.description,
    account: account,
    start_date: 5.years.ago
  yield(transaction, budgeted_line_item)
  budgeted_line_item.save!
  transaction.save!
  transaction.account
end
