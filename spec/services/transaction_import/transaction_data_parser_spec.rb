describe TransactionImport::TransactionDataParser do
  include CsvFileExamples

  context "for a transaction file with a header and named columns" do
    describe "#call" do
      it "imports properly" do
        account = create :account, import_configuration_options: include_headers_options
        imported_file = ImportedFile.new()
        imported_file.account = account
        imported_file.source_file.attach(io: File.open(Rails.root + "spec/support/transaction_csv_with_header_and_non_iso_dates.csv"), filename: "attachment.csv", content_type: "text/csv")
        transaction_import = TransactionImport::TransactionDataParser.new(account, imported_file)
        transaction_import.call()

        first_transaction = account.transactions[0]
        second_transaction = account.transactions[1]
        expect(first_transaction.transaction_date).to eq(Date.new(2017, 5, 1))
        expect(first_transaction.description).to eq("INTERNET BILL PAYMENT CABLE")
        expect(first_transaction.amount).to eq(Money.new(-91))
        expect(second_transaction.transaction_date).to eq(Date.new(2017, 5, 2))
        expect(second_transaction.description).to eq("CHEQUE IMAGE DEPOSIT")
        expect(second_transaction.amount).to eq(Money.new(200))
      end
    end
  end
end
