class AccountsController
  class TransactionSnapshot
    attr_reader :description, :amount_cents, :transaction_date, :remaining_balance

    def initialize(description, amount_cents, transaction_date, remaining_balance)
      @description = description
      @amount_cents = amount_cents
      @transaction_date = transaction_date
      @remaining_balance = remaining_balance
    end
  end
end
