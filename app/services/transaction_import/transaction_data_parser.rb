require 'csv'

module TransactionImport
  class TransactionDataParser

    attr_accessor :account
    attr_accessor :imported_file
    attr_accessor :options

    def initialize(account, imported_file)
      @account = account
      @imported_file = imported_file
      import_options = account.import_configuration_options
      @options = import_options.reverse_merge(default_options)
    end

    def call()
      csv_options = {
        headers: true,
        header_converters: lambda {|f| f.strip},
        converters: lambda {|f| f ? f.strip : nil}
      }
      transactions = []
      CSV.parse(@imported_file.source_file.download, csv_options) do |row|
        transactions << create_transaction_from_row(row)
      end
      transaction_importer = TransactionDataImporter.new(@account, transactions)
      transaction_importer.call()
    end

    private

    def create_transaction_from_row(row)
      date_column_string = row[@options["date_column_name"]]
      description_column = row[@options["description_column_name"]]
      funds_in_column_string= row[@options["funds_in_column_name"]]
      funds_out_column_string = row[@options["funds_out_column_name"]]
      date_column = Date.strptime(date_column_string, @options["date_format"])
      if(funds_in_column_string.nil?)
        amount_column = -Float(funds_out_column_string)
      else
        amount_column = Float(funds_in_column_string)
      end

      transaction = Transaction.new()
      transaction.account = @account
      transaction.imported_file = @imported_file
      transaction.description = description_column
      transaction.transaction_date = date_column
      transaction.amount_cents = amount_column
      transaction
    end

    def default_options()
      {
        "includes_headers": true,
        "date_column_name": 'date',
        "description_column_name": 'description',
        "funds_in_column_name": 'funds_in',
        "funds_out_column_name": 'funds_out',
        "date_format": '%Y-%m-%d',
        "date_position": 1,
        "description_position": 2,
        "funds_in_position": 3,
        "funds_out_position": 4
      }
    end
  end
end
