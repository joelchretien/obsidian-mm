module TransactionReporting
  class TransactionTimelineItem
    attr_reader :description, :amount_cents, :transaction_date, :expected_date, :balance_cents

    def initialize(description, amount_cents, transaction_date, expected_date, balance_cents)
      @description = description
      @amount_cents = amount_cents
      @transaction_date = transaction_date
      @expected_date = expected_date
      @balance_cents = balance_cents
    end
  end
end
