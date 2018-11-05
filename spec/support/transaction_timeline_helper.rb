def create_transaction_and_budget(account: nil)
  if account.nil?
    account = create :account
  end
  transaction = build :transaction, account: account
  budgeted_line_item = build :budgeted_line_item,
    transaction_descriptions: transaction.description,
    account: account,
    start_date: 5.years.ago
  yield(transaction, budgeted_line_item)
  budgeted_line_item.save!
  transaction.save!
  transaction.account
end
