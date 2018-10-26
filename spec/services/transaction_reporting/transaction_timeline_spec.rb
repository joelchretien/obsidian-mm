module TransactionReporting
  describe TransactionTimeline do
    context "#call" do
      context "transactions" do
        context "when a transaction is between the start date and end date" do
          it "is included in the timeline" do
            transaction = create :transaction, transaction_date: Date.today

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end
        context "when a transaction is before the start date" do
          it "is not included in the timeline" do
            transaction = create :transaction, transaction_date: 1.month.ago - 1.day

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end
        context "when a transaction is after the end date" do
          it "is not included in the timeline" do
            transaction = create :transaction, transaction_date: Date.today + 1.month - 1.day

            report = one_month_window_timeline(transaction.account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items).to match_timelines_to_transactions([transaction])
          end
        end

        context "when there are no transactions" do
          it "returns an empty timeline" do
            account = create :account

            report = one_month_window_timeline(account)
            transaction_timeline_items = report.call

            expect(transaction_timeline_items.empty?).to eq(true)
          end
        end
      end

      context "budgeted line items" do
        context "when it is overdue" do
          it "returns a transaction date of today" do
            account = create_transaction_and_budget() do |transaction, budget|
              transaction.transaction_date = Date.today - 2.months
              budget.recurrence = :monthly
              budget.recurrence_multiplier = 1
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines[0].transaction_date).to eq(Date.today)
          end

          it "returns multiple timeline items for a budgeted line item that repeats itself before the end date" do
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

        context "when it is not overdue" do
          it "returns the expected timeline item date" do
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

        context "when no matching transaction has yet occurred" do
          context "and the start date is before today" do
            it "it returns today" do
              account = create_transaction_and_budget() do |transaction, budget|
                budget.description = "Something Else"
                budget.start_date = Date.today - 1.day
              end

              report = one_month_window_timeline(account)
              timelines = report.call

              expect(timelines.count).to eq(2)
              expect(timelines[1].transaction_date).to eq(Date.today)
            end
          end

          context "and the start date is after today" do
            it "returns the start date" do
              account = create_transaction_and_budget() do |transaction, budget|
                budget.description = "Something Else"
                budget.start_date = Date.today + 1.day
              end

              report = one_month_window_timeline(account)
              timelines = report.call

              expect(timelines.count).to eq(2)
              expect(timelines[1].transaction_date).to eq(Date.today + 1.day)
            end
          end
        end

        context "when a non-recurring budgeted line item is present" do
          context "and the start date is after today" do
            it "returns the start date once"
          end

          context "and the start date is before today" do
            it "returns the a date of today once"
          end
        end

        context "when it is expected after the end date" do
          it "should not be included" do
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

        context "when calculating the balance for budgeted line items" do
          context "when it is a single budgeted line items" do
            it "adds the budgeted line item to the last transactions" do
              account = create_transaction_and_budget() do |transaction, budget|
                transaction.transaction_date = Date.today - 2.weeks
                budget.recurrence = :monthly
                budget.recurrence_multiplier = 1
              end

              report = one_month_window_timeline(account)
              timelines = report.call

              transaction = account.transactions.first
              budgeted_line_item = account.budgeted_line_items.first
              new_balance = transaction.balance + budgeted_line_item.amount

              expect(timelines.last.balance).to eq(new_balance)
            end
          end
        end

        context "when it is multiple budgeted line items" do
          it "shows the balances in chronological order" do
            account = create :account
            create_transaction_and_budget(account: account) do |transaction, budget|
              transaction.transaction_date = Date.today + 1.weeks + 5.day
              transaction.amount = Money.from_amount(5)
              transaction.balance = Money.from_amount(5)
              budget.recurrence = :weekly
              budget.recurrence_multiplier = 1
              budget.amount = Money.from_amount(5)
            end
            create_transaction_and_budget(account: account) do |transaction, budget|
              transaction.transaction_date = Date.today + 1.weeks + 6.day
              transaction.amount = Money.from_amount(10)
              transaction.balance = Money.from_amount(15)
              budget.recurrence = :weekly
              budget.recurrence_multiplier = 1
              budget.amount = Money.from_amount(10)
            end

            report = one_month_window_timeline(account)
            timelines = report.call

            expect(timelines.count).to eq(6)
            expect(timelines[2].transaction_date).to eq(Date.today + 2.weeks + 5.day)
            expect(timelines[3].transaction_date).to eq(Date.today + 2.weeks + 6.day)
            expect(timelines[4].transaction_date).to eq(Date.today + 3.weeks + 5.day)
            expect(timelines[5].transaction_date).to eq(Date.today + 3.weeks + 6.day)

            expect(timelines[2].amount).to eq(Money.from_amount(5))
            expect(timelines[3].amount).to eq(Money.from_amount(10))
            expect(timelines[4].amount).to eq(Money.from_amount(5))
            expect(timelines[5].amount).to eq(Money.from_amount(10))

            expect(timelines[2].balance).to eq(Money.from_amount(20))
            expect(timelines[3].balance).to eq(Money.from_amount(30))
            expect(timelines[4].balance).to eq(Money.from_amount(35))
            expect(timelines[5].balance).to eq(Money.from_amount(45))
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
            actual.amount != expected.amount ||
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
  end
end
