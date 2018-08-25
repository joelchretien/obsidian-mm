class ImportedFilesController < ApplicationController
  respond_to :html, :json

  def new
    @account = Account.find(params[:account_id])
    @imported_file = ImportedFile.new()
    respond_modal_with @imported_file
  end
  def create
    @account = Account.find(params[:account_id])

    #TODO: Create controls that enable this to be setup
    @account.import_configuration_options = include_headers_options

    @imported_file = ImportedFile.new(imported_file_params)
    @imported_file.account = @account
    @imported_file.save!
    transaction_import = TransactionImport::TransactionDataParser.new(@account, @imported_file)
    transaction_import.call()

    respond_modal_with @imported_file, location: account_transactions_path(@account)
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

  def imported_file_params
    params.require(:imported_file).permit(:source_file)
  end
end
