module TransactionImport
  class TransactionDataImporter
    attr_accessor :transactions, :account, :last_balance

    def initialize(account, transactions, last_balance: nil)
      @account = account
      @transactions = transactions
      if !last_balance.nil?
        @last_balance = Money.from_amount(last_balance)
      end
    end

    def call
      existing_last_day_transactions = @account.transactions_for_last_day
      last_day = get_last_day(existing_last_day_transactions)

      newer_transactions = @transactions.select { |transaction| transaction.transaction_date > last_day }
      new_last_day_transactions = @transactions.select { |transaction| transaction.transaction_date == last_day }
      remove_duplicates(new_last_day_transactions, existing_last_day_transactions)
      all_transactions = new_last_day_transactions + newer_transactions
      set_transaction_balances(all_transactions)
      assign_budgeted_line_items(all_transactions)
      all_transactions.each do |transaction|
        if !transaction.valid?
          raise "One or more transactions are invalid"
        end
      end
      Transaction.import(all_transactions)
      create_user_entered_balance(account.last_transaction)
    end

    private

    def assign_budgeted_line_items(transactions)
      transactions.each do |transaction|
        matching_items = @account.budgeted_line_items.find_all { |item| item.transaction_descriptions == transaction.description }
        if !matching_items.empty?
          transaction.budgeted_line_item = matching_items.first
        end
      end
    end

    def set_transaction_balances(transactions)
      last_transaction = @account.last_transaction
      if last_transaction.nil?
        # This is the first time we import, use the last_balance parameter
        balance = last_balance
        transactions.reverse_each do |transaction|
          transaction.balance = balance
          balance -= transaction.amount
        end
      else
        # We've already imported before for this account.  Start the balance
        # where we left off
        balance = last_transaction.balance
        transactions.each do |transaction|
          balance += transaction.amount
          transaction.balance = balance
        end
      end
    end

    def create_user_entered_balance(last_transaction)
      if !last_transaction.nil? && !@last_balance.nil?
        user_entered_balance = UserEnteredBalance.new()
        user_entered_balance.balance_transaction = last_transaction
        user_entered_balance.account = account
        user_entered_balance.balance = @last_balance
        user_entered_balance.save!
      end
    end

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
