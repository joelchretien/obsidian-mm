module TransactionReporting
  class TimelineItem
    attr_accessor :description, :amount, :transaction_date, :expected_date, :balance, :is_future

    def self.from_transaction(transaction)
      t = TimelineItem.new()
      t.description = transaction.description
      t.amount = transaction.amount
      t.transaction_date = transaction.transaction_date
      t.balance = transaction.balance
      t.is_future = false
      t
    end

    def self.from_budgeted_line_item(budgeted_line_item, transaction_date:, expected_date:)
      t = TimelineItem.new()
      t.description = budgeted_line_item.description
      t.amount = budgeted_line_item.amount
      t.transaction_date = transaction_date
      t.expected_date = expected_date
      t.is_future = true
      t
    end
  end
end
