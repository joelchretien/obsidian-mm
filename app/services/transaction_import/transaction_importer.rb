module TransactionImport
  class TransactionImporter
    attr_accessor :account
    attr_accessor :transactions

    def initializer(account, transactions)
      @account = account
      @transactions = transactions
    end
  end
end
