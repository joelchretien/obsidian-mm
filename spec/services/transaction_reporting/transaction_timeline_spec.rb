module TransactionReporting
  describe TransactionTimeline do
    context '#call' do
      context 'transactions' do

        context 'when a transaction is between the start date and end date' do
          it 'is included in the timeline' do
            transaction = create :transaction, transaction_date: Date.today

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end
        context 'when a transaction is before the start date' do
          it 'is not included in the timeline' do
            transaction = create :transaction, transaction_date: 1.month.ago - 1.day

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end
        context 'when a transaction is after the end date' do
          it 'is not included in the timeline' do
            transaction = create :transaction, transaction_date: Date.today + 1.month - 1.day

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end
      end

      context 'budgeted line items' do
        context 'when it is overdue' do
          it 'returns a transaction date of today' do
            account = create_transaction_and_budget() do |transaction, budget|
              transaction.transaction_date = Date.today - 2.months
              budget.recurrence = :monthly
              budget.recurrence_multiplier = 1
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines[0].transaction_date).to eq(Date.today)
          end

          it 'returns multiple timeline items for a budgeted line item that repeats itself before the end date' do
            account = create_transaction_and_budget() do |transaction, budget|
              transaction.transaction_date = Date.today - 1.months - 1.day
              budget.recurrence = :monthly
              budget.recurrence_multiplier = 1
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines.count).to eq(2)
            expect(timelines[0].transaction_date).to eq(Date.today)
          end
        end

        context 'when it is not overdue' do
          it 'returns the expected timeline item date' do
            account = create_transaction_and_budget() do |transaction, budget|
              transaction.transaction_date = Date.today - 2.weeks
              budget.recurrence = :monthly
              budget.recurrence_multiplier = 1
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines.count).to eq(2)
            expect(timelines[1].transaction_date).to eq(Date.today - 2.weeks + 1.month)
          end
        end

        context 'when it is expected after the end date' do
          it 'should not be included' do
            account = create_transaction_and_budget() do |transaction, budget|
              transaction.transaction_date = Date.today + 2.weeks
              budget.recurrence = :monthly
              budget.recurrence_multiplier = 1
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines.count).to eq(1)
          end
        end

      end

    end

    RSpec::Matchers.define :match_timelines_to_transactions do |expected_transactions|
      match do |actual_timeline_items|
        false if expected_transactions.count != actual_timeline_items.count

        mismatch_found = false
        actual_timeline_items.each_with_index do |actual, index|
          expected = expected_transactions[index]
          mismatch_found = actual.description != expected.description ||
            actual.transaction_date != expected.transaction_date ||
            actual.amount_cents != expected.amount_cents ||
            !actual.expected_date.nil?
        end
        return !mismatch_found
      end
    end

    def one_month_window_timeline(account)
      start_date = Date.today - 1.month
      end_date = Date.today + 1.month
      TransactionTimeline.new(account, start_date, end_date)
    end

    def create_transaction_and_budget()
      transaction = create :transaction
      budgeted_line_item = create :budgeted_line_item,
        description: transaction.description,
        account: transaction.account,
        start_date: 5.years.ago
      yield(transaction, budgeted_line_item)
      budgeted_line_item.save!
      transaction.save!
      transaction.account
    end
  end
end
