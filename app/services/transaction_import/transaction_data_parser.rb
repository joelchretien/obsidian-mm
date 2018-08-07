require 'csv'

module TransactionImport
  class TransactionDataParser

    attr_accessor :user
    attr_accessor :transaction_row_array
    attr_accessor :options

    def initialize(user, transaction_file_contents, options = {})
      @user = user
      @transaction_file_contents = transaction_file_contents
      default_options = {
        includes_headers: true,
        date_column_name: 'date',
        description_column_name: 'description',
        funds_in_column_name: 'funds_in',
        funds_out_column_name: 'funds_out',
        date_format: '%Y-%m-%d',
        date_position: 1,
        description_position: 2,
        funds_in_position: 3,
        funds_out_position: 4
      }

      @options = options.reverse_merge(default_options)
    end

    def call()
      csv_options = {
        headers: true,
        header_converters: lambda {|f| f.strip},
        converters: lambda {|f| f ? f.strip : nil}
      }

      CSV.parse(@transaction_file_contents, csv_options) do |row|
        date_column_string = row[@options[:date_column_name]]
        description_column = row[@options[:description_column_name]]
        funds_in_column_string= row[@options[:funds_in_column_name]]
        funds_out_column_string = row[@options[:funds_out_column_name]]

        date_column = Date.strptime(date_column_string, @options[:date_format])
        if(funds_in_column_string.nil?)
          amount_column = -Float(funds_out_column_string)
        else
          amount_column = Float(funds_in_column_string)
        end

        transaction = Transaction.new()
        transaction.user = @user
        transaction.description = description_column
        transaction.transaction_date = date_column
        transaction.amount_cents = amount_column
        transaction.save()
      end
    end
  end
end
