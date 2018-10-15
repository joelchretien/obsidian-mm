module TransactionImport
  class TransactionDataImporter
    attr_accessor :transactions, :account

    def initialize(account, transactions)
      @account = account
      @transactions = transactions
    end

    def call
      existing_last_day_transactions = @account.transactions_for_last_day
      last_day = get_last_day(existing_last_day_transactions)

      newer_transactions = @transactions.select { |transaction| transaction.transaction_date > last_day }
      new_last_day_transactions = @transactions.select { |transaction| transaction.transaction_date == last_day }
      remove_duplicates(new_last_day_transactions, existing_last_day_transactions)
      all_transactions = new_last_day_transactions + newer_transactions
      Transaction.import(all_transactions)
    end

    private

    def get_last_day(existing_last_day_transactions)
      if existing_last_day_transactions.empty?
        Time.at(0).to_date
      else
        existing_last_day_transactions.first.transaction_date
      end
    end

    def remove_duplicates(new_last_day_transactions, last_day_transactions)
      new_last_day_transactions.delete_if do |new_transaction|
        last_day_transactions.select do |existing_transaction|
          existing_transaction.is_duplicate(new_transaction)
        end
      end
    end
  end
end
