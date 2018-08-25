class ImportedFilesController < ApplicationController
  def create
    account = Account.find(params[:account_id])

    #TODO: Create controls that enable this to be setup
    account.import_configuration_options = include_headers_options

    imported_file = ImportedFile.new()
    imported_file.account = account
    imported_file.source_file.attach(params[:source_file])
    transaction_import = TransactionImport::TransactionDataParser.new(account, imported_file)
    transaction_import.call()
    redirect_to account_transactions_path(account)
  end

  private

  def include_headers_options()
    {
      includes_headers: true,
      date_column_name: 'Date',
      description_column_name: 'Transaction Details',
      funds_in_column_name: 'Funds In',
      funds_out_column_name: 'Funds Out',
      date_format: '%m/%d/%Y'
    }
  end
end
