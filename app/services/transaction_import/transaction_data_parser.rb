module TransactionImport
  class TransactionDataParser

    attr_accessor :transaction_array
    attr_accessor :options

    def new(transaction_array, options = {})
      @transaction_array = transaction_array
      @options = options
    end

    def call()
      
    end
  end
end
