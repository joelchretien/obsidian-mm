class ImportFileRequest
  include ActiveModel::Model

  attr_accessor :account, :source_file, :last_balance
  validates :account, presence: true
  validates :source_file, presence: true
  validates :last_balance, numericality: true, presence: true, if: :last_balance_required?


  def last_balance_required?
    return false if @account.nil?
    !@account.imported_files.any?
  end

  def register
    # TODO: This line can be removed when issue #16 is closed
    @account.import_configuration_options = include_headers_options
    imported_file = ImportedFile.new(source_file: @source_file)
    imported_file.account = @account
    imported_file.save!
    transaction_import = TransactionImport::CsvParser.new(imported_file)
    transaction_import.call(last_balance: @last_balance.to_f)
  end

  private

  def include_headers_options
    {
      includes_headers: true,
      date_column_name: "Date",
      description_column_name: "Transaction Details",
      funds_in_column_name: "Funds In",
      funds_out_column_name: "Funds Out",
      date_format: "%m/%d/%Y"
    }
  end
end
