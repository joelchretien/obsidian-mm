require "csv"

module TransactionImport
  class TransactionDataParser
    attr_accessor :imported_file
    attr_accessor :options

    def initialize(imported_file)
      @imported_file = imported_file
      import_options = imported_file.account.import_configuration_options
      @options = import_options.reverse_merge(default_options)
    end

    def call(last_balance: nil)
      csv_options = {
        headers: true,
        header_converters: lambda { |f| f.strip },
        converters: lambda  { |f| f ? f.strip : nil }
      }
      transactions = []
      file_contents = @imported_file.source_file.download
      cleaned_file_contents = clean_file_contents(file_contents)
      CSV.parse(cleaned_file_contents, csv_options) do |row|
        transaction = create_transaction_from_row(row)
        transaction.imported_file = @imported_file
        transactions << transaction
      end
      transaction_importer = TransactionDataImporter.new(
        imported_file.account,
        transactions,
        last_balance: last_balance
      )
      transaction_importer.call()
    end

    private

    def clean_file_contents(file_contents)
      cleaned_quotes = file_contents.gsub(/\"/, "")
      cleaned_quotes
    end

    def create_transaction_from_row(row)
      date_column_string = row[@options["date_column_name"]]
      description_column = row[@options["description_column_name"]]
      funds_in_column_string = row[@options["funds_in_column_name"]]
      funds_out_column_string = row[@options["funds_out_column_name"]]
      date_column = Date.strptime(date_column_string, @options["date_format"])
      if funds_in_column_string.nil?
        amount_column = -Float(funds_out_column_string)
      else
        amount_column = Float(funds_in_column_string)
      end

      transaction = Transaction.new()
      transaction.account = imported_file.account
      transaction.imported_file = @imported_file
      transaction.description = description_column
      transaction.transaction_date = date_column
      transaction.amount = amount_column
      transaction
    end

    def default_options
      {
        "includes_headers": true,
        "date_column_name": "date",
        "description_column_name": "description",
        "funds_in_column_name": "funds_in",
        "funds_out_column_name": "funds_out",
        "date_format": "%Y-%m-%d",
        "date_position": 1,
        "description_position": 2,
        "funds_in_position": 3,
        "funds_out_position": 4
      }
    end
  end
end
