module TransactionReporting
  class TransactionTimelineItem
    attr_reader :description, :amount, :transaction_date, :expected_date
    attr_accessor :balance

    def initialize(description, amount, transaction_date, expected_date, balance)
      @description = description
      @amount = amount
      @transaction_date = transaction_date
      @expected_date = expected_date
      @balance = balance
    end
  end
end
