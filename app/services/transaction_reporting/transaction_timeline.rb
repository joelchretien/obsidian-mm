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
      past_timelines = transactions.collect { |t| TransactionTimelineItem.from_transaction(t) }
      future_timelines = budgeted_line_item_timelines()

      past_timelines + future_timelines
    end

    private

    def budgeted_line_item_timelines
      upcoming_timelines = get_upcoming_timelines()
      set_expected_balances(upcoming_timelines)
    end

    def get_upcoming_timelines
      upcoming_timelines = []
      latest_transactions_service = LatestTransactionsByDescriptions.new(account)
      latest_transactions = latest_transactions_service.call()
      account.budgeted_line_items.each do |budgeted_line_item|
        latest_matching_transaction = latest_transactions.find { |transaction| budgeted_line_item.matches_transaction(transaction) }
        timelines = get_timeline_for_budgeted_line_item(budgeted_line_item, latest_matching_transaction)
        upcoming_timelines.push(*timelines)
      end
      upcoming_timelines.sort_by { |n| n.transaction_date }
    end

    def set_expected_balances(upcoming_timelines)
      current_balance = account.last_transaction.balance
      upcoming_timelines.each do |timeline|
        current_balance += timeline.amount
        timeline.balance = current_balance
      end
    end

    def get_timeline_for_budgeted_line_item(budgeted_line_item, latest_matching_transaction)
      timelines = []
      if latest_matching_transaction.nil?
        current_date = budgeted_line_item.start_date
      else
        current_date = latest_matching_transaction.transaction_date
      end
      past_end_of_report = false
      while !past_end_of_report do
        next_date = budgeted_line_item.next_date(current_date)
        transaction_date = next_date < Date.today ? Date.today : next_date
        if next_date <= @end_date
          timeline = TransactionTimelineItem.from_budgeted_line_item(
            budgeted_line_item,
            expected_date: next_date,
            transaction_date: transaction_date
          )
          timelines << timeline
          current_date = next_date
        else
          past_end_of_report = true
        end
      end
      timelines
    end
  end
end
