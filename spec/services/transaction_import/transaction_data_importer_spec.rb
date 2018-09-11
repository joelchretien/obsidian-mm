describe TransactionImport::TransactionDataImporter do
  include CsvFileExamples

  context 'for a transactions that overlap' do
    describe '#call' do
      it 'doesn\'t duplicate transactions' do
        #TODO: Remove the complexity here.  Just add the same transactions
        #twice.  Create another test for adding a file with one transaction and
        #another with two of the same.
        transactions_hash = create_transactions_hash()

        file1_transaction1 = transactions_hash[:file1_transaction1]
        file1_transaction2 = transactions_hash[:file1_transaction2]
        file2_transaction1 = transactions_hash[:file2_transaction1]
        file2_transaction2 = transactions_hash[:file2_transaction2]

        match_transaction_properties(file1_transaction2, file2_transaction1)
        import_transactions(transactions_hash)

        expected_transactions = [file1_transaction1, file1_transaction2, file2_transaction2]
        actual_transactions = transactions_hash[:account].transactions
        expect(actual_transactions.count).to eq(expected_transactions.count)
        expect(actual_transactions).to match_transactions(expected_transactions)
      end

      def import_transactions(transactions_hash)
        transactions_hash[:transaction_import1].call()
        transactions_hash[:transaction_import2].call()
      end

      RSpec::Matchers.define :match_transactions do |expected_transactions|
        match do |actual_transactions|
          false if expected_transactions.count != actual_transactions.count

          mismatch_found = false
          actual_transactions.each_with_index do |actual, index|
           expected = expected_transactions[index]
           mismatch_found = actual.description != expected.description ||
            actual.transaction_date != expected.transaction_date ||
            actual.amount_cents != expected.amount_cents
          end
          return !mismatch_found
        end
      end

      def create_transaction(transactions, account, imported_file)
        transaction = build :transaction, account: account, imported_file: imported_file
        transactions << transaction
        transaction
      end

      def match_transaction_properties(target, source)
        target.description = source.description
        target.amount = source.amount
        target.transaction_date = source.transaction_date
      end

      def create_transactions_hash()
        transactions_hash = {}
        user = create :user
        transactions_hash[:account] = create :account, user: user, import_configuration_options: include_headers_options
        account = transactions_hash[:account]
        imported_file1 = ImportedFile.new()
        imported_file1.account = account

        file1_transactions = []
        transactions_hash[:file1_transaction1] = create_transaction(file1_transactions, account, imported_file1)
        transactions_hash[:file1_transaction2] = create_transaction(file1_transactions, account, imported_file1)

        transactions_hash[:transaction_import1] = TransactionImport::TransactionDataImporter.new(account, file1_transactions)

        imported_file2 = ImportedFile.new()
        imported_file2.account = account

        file2_transactions = []
        transactions_hash[:file2_transaction1] = create_transaction(file2_transactions, account, imported_file2)
        transactions_hash[:file2_transaction2] = create_transaction(file2_transactions, account, imported_file2)

        transactions_hash[:transaction_import2] = TransactionImport::TransactionDataImporter.new(account, file2_transactions)
        transactions_hash
      end
    end
  end
end
