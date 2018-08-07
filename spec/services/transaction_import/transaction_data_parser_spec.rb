describe TransactionImport::TransactionDataParser do
  include CsvFileExamples

  context 'for a transaction file with a header and named columns' do
    describe '#call' do
      it "imports properly" do
        #TODO: Cut down on the expectations in this test
        user = FactoryBot.create :current_user
        transaction_csv = transaction_csv_with_header_and_non_iso_dates()
        transaction_import = TransactionImport::TransactionDataParser.new(user, transaction_csv, {
          includes_headers: true,
          date_column_name: 'Date',
          description_column_name: 'Transaction Details',
          funds_in_column_name: 'Funds In',
          funds_out_column_name: 'Funds Out',
          date_format: '%m/%d/%Y'
        })
        transaction_import.call()

        first_transaction = user.transactions[0]
        second_transaction = user.transactions[1]
        expect(first_transaction.transaction_date).to eq(Date.new(2017,5,1))
        expect(first_transaction.description).to eq('INTERNET BILL PAYMENT CABLE')
        expect(first_transaction.amount).to eq(Money.new(-91))
        expect(second_transaction.transaction_date).to eq(Date.new(2017,5,2))
        expect(second_transaction.description).to eq('CHEQUE IMAGE DEPOSIT')
        expect(second_transaction.amount).to eq(Money.new(200))
      end
    end
  end
end
