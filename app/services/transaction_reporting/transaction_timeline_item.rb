module TransactionReporting
  class TransactionTimelineItem
    attr_reader :description, :amount_cents, :transaction_date, :expected_date

    def initialize(description, amount_cents, transaction_date, expected_date)
      @description = description
      @amount_cents = amount_cents
      @transaction_date = transaction_date
      @expected_date = expected_date
    end
  end
end
