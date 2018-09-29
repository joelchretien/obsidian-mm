module TransactionReporting
  describe LatestTransactionsByDescriptions do

   context '#call' do
      it 'returns the latest by description' do
        account = create :account
        transaction1 = transactions_with_same_descriptions(account)
        transaction2 = transactions_with_same_descriptions(account)

        latest_transactions_by_descriptions = LatestTransactionsByDescriptions.new(account)
        transactions = latest_transactions_by_descriptions.call()

        expect(transactions).to eq([transaction1, transaction2])
      end
    end

    def transactions_with_same_descriptions(account)
      imported_file = create :imported_file, account: account
      transaction_duplicated1 = create :transaction, account: account, imported_file: imported_file
      transaction_duplicated2 = create :transaction, account: account, imported_file: imported_file, description: transaction_duplicated1.description
      transaction_duplicated2
    end
  end
end
