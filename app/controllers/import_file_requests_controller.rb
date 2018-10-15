class ImportFileRequestsController < ApplicationController
  respond_to :html, :json

  def new
    @account = Account.find(params[:account_id])
    @import_file_request = ImportFileRequest.new()
    @import_file_request.account = @account
    respond_modal_with @import_file_request
  end

  def create
    @account = Account.find(params[:account_id])
    @import_file_request = ImportFileRequest.new()
    @import_file_request.account = @account
    @import_file_request.attributes = import_file_request_params
    @import_file_request.register
    respond_modal_with @imported_file, location: account_transactions_path(@import_file_request.account)
  end

  def import_file_request_params
    params.require(:import_file_request).permit(:source_file, :last_balance)
  end
end
