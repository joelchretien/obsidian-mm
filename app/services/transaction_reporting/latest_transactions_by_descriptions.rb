module TransactionReporting
  class LatestTransactionsByDescriptions

    attr_reader :account

    def initialize(account)
      @account = account
    end

    def call()
      latest_transactions
    end

    private

    def inner_query
      Transaction
        .select('*, ROW_NUMBER() OVER (partition by description order by transaction_date desc) as date_rank')
        .where(account_id: @account.id)
        .to_sql
    end

    def latest_transactions
      Transaction
        .select('*')
        .from("(#{inner_query}) as latest_transactions")
        .where('date_rank = 1')
        .to_a
    end
  end
end
