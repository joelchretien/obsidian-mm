class AccountsController < ApplicationController
  respond_to :html, :json

  def index
    @accounts = current_user.accounts.order('name')
  end

  def new
    @account = Account.new
    respond_modal_with @account
  end

  def edit
    @account = current_user.accounts.find(params[:id])
    respond_modal_with @account
  end

  def create
    @account = Account.new(account_params)
    @account.user = current_user
    #TODO: Create controls to specify options
    @account.import_configuration_options = { hello: "hello" }.to_json
    @account.save
    respond_modal_with @account, location: accounts_path
  end

  def update
    @account = current_user.accounts.find(params[:id])
    @account.update(account_params)
    respond_modal_with @account, location: accounts_path
  end

  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end

  private 

  def account_params
    params.require(:account).permit(:name)
  end
end
