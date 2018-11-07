describe TransactionReporting::ChartDataQuery do
  context "when there are multiple transactions in a day" do
    it "returns the latest" do
      account = create :account
      transaction1 = create :transaction, account: account, transaction_date: Date.today
      transaction2 = create :transaction, account: account, transaction_date: transaction1.transaction_date

      transaction_timelines = TransactionReporting::TimelineQuery.new(
        account,
        Date.yesterday,
        Date.today + 1.day
      ).call
      chart_data = TransactionReporting::ChartDataQuery.new(transaction_timelines).call

      expected_array = [[ transaction2.transaction_date, transaction2.balance.to_f ]]
      expect(chart_data).to match_array(expected_array)
    end
  end
end
