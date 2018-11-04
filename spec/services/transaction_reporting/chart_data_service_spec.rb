describe TransactionReporting::ChartDataService do
  context "when there are multiple transactions in a day" do
    it "returns the latest" do
      transaction1 = create :transaction
      transaction2 = create :transaction, transaction_date: transaction1.transaction_date

    end
  end
end
