describe TransactionImport::TransactionDataImporter do
  include CsvFileExamples

  context "for a transactions that overlap" do
    it "does not duplicate transactions" do
      account = create_account
      imported_file1 = create_imported_file(account)
      file1_transactions = build_two_transactions(account, imported_file1)
      transaction_importer1 = get_transaction_importer(account, file1_transactions, last_balance: 100)
      imported_file2 = create_imported_file(account)
      file2_transactions = build_two_transactions(account, imported_file2)
      transaction_importer2 = get_transaction_importer(account, file2_transactions)

      file1_transaction1 = file1_transactions[0]
      file1_transaction2 = file1_transactions[1]
      file2_transaction1 = file2_transactions[0]
      file2_transaction2 = file2_transactions[1]

      match_transaction_properties(file1_transaction2, file2_transaction1)
      transaction_importer1.call()
      transaction_importer2.call()

      expected_transactions = [file1_transaction1, file1_transaction2, file2_transaction2]
      actual_transactions = account.transactions
      expect(actual_transactions.count).to eq(expected_transactions.count)
      expect(actual_transactions).to match_transactions(expected_transactions)
    end
  end

  context "when the first file is saved" do
    it "creates a user specified balance" do
      account = create_account
      imported_file = create_imported_file(account)
      file_transactions = build_two_transactions(account, imported_file)
      last_balance = 100
      transaction_importer = get_transaction_importer(account, file_transactions, last_balance: last_balance)
      transaction_importer.call()

      expect(UserEnteredBalance.count).to eq(1)
      balance = UserEnteredBalance.first
      expect([balance.balance_transaction]).to match_transactions([file_transactions[1]])
      expect(balance.account).to eq(account)
      expect(balance.balance).to eq(Money.from_amount(last_balance))
    end
  end

  context "when a budgeted line has a single transaction description" do
    context "and an imported transaction matches the description" do
      it "automatically assigns the transactions" do
        user = create :user
        account = create :account, user: user
        budgeted_line_item = build :budgeted_line_item, account: account
        imported_file = create_imported_file(account)
        file_transactions = build_two_transactions(account, imported_file)
        budgeted_line_item.transaction_descriptions = file_transactions.first.description
        budgeted_line_item.save!
        transaction_importer = get_transaction_importer(account, file_transactions, last_balance: 100)
        transaction_importer.call()

        expect(file_transactions.first.budgeted_line_item).to eq(budgeted_line_item)
      end
    end
  end

end

def create_account
  user = create :user
  account = create :account,
    user: user,
    import_configuration_options: include_headers_options
  account
end

def create_imported_file(account)
  imported_file1 = ImportedFile.new()
  imported_file1.account = account
  imported_file1.save!
  imported_file1
end

def build_two_transactions(account, imported_file)
  transactions = []
  transaction1 = build :transaction, account: account, imported_file: imported_file
  transactions << transaction1
  transaction2 = build :transaction, account: account, imported_file: imported_file
  transactions << transaction2
  transactions
end

def get_transaction_importer(account, transactions, last_balance: nil)
  importer = TransactionImport::TransactionDataImporter.new(
    account,
    transactions,
    last_balance: last_balance
  )
  importer
end

def match_transaction_properties(target, source)
  target.description = source.description
  target.amount = source.amount
  target.transaction_date = source.transaction_date
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
