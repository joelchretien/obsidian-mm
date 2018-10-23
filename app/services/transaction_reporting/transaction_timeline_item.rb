module TransactionReporting
  class TransactionTimelineItem
    attr_accessor :description, :amount, :transaction_date, :expected_date, :balance

    def self.from_transaction(transaction)
      t = TransactionTimelineItem.new()
      t.description = transaction.description
      t.amount = transaction.amount
      t.transaction_date = transaction.transaction_date
      t.balance = transaction.balance
      t
    end

    def self.from_budgeted_line_item(budgeted_line_item, transaction_date:, expected_date:)
      t = TransactionTimelineItem.new()
      t.description = budgeted_line_item.description
      t.amount = budgeted_line_item.amount
      t.transaction_date = transaction_date
      t.expected_date = expected_date
      t
    end
  end
end
