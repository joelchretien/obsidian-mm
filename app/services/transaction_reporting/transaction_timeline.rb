module TransactionReporting
  class TransactionTimeline
    attr_reader :account, :start_date, :end_date

    def initialize(account, start_date, end_date)
      @account = account
      @start_date = start_date
      @end_date = end_date
    end

    def call
      transactions = Transaction.between_dates(@start_date, @end_date)
      past_timelines = transactions.collect { |t| transaction_to_timeline(t) }
      future_timelines = budgeted_line_item_timelines()

      past_timelines + future_timelines
    end

    private

    def transaction_to_timeline(transaction)
      TransactionTimelineItem.new(
        transaction.description,
        transaction.amount_cents,
        transaction.transaction_date,
        nil,
        transaction.balance
      )
    end

    def budgeted_line_item_timelines
      timelines = []
      latest_transactions_service = LatestTransactionsByDescriptions.new(account)
      latest_transactions = latest_transactions_service.call()
      last_transaction = account.last_transaction
      balance = last_transaction.balance_cents
      account.budgeted_line_items.each do |budgeted_line_item|
        balance = balance + budgeted_line_item.amount_cents
        latest_matching_transaction = latest_transactions.first { |transaction| budgeted_line_item.matches_transaction(transaction) }
        current_date = latest_matching_transaction.nil? ? budgeted_line_item.start_date : latest_matching_transaction.transaction_date
        past_end_of_report = false
        while !past_end_of_report do
          next_date = budgeted_line_item.next_date(current_date)
          transaction_date = next_date < Date.today ? Date.today : next_date
          if next_date <= @end_date
            timeline = TransactionTimelineItem.new(
              budgeted_line_item.description,
              budgeted_line_item.amount_cents,
              transaction_date,
              next_date,
              balance
            )
            timelines << timeline
            current_date = next_date
          else
            past_end_of_report = true
          end
        end
      end

      timelines.sort_by { |n| n.transaction_date }
    end
  end
end
