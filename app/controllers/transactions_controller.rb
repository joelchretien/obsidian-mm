class TransactionsController < ApplicationController
  def index
    @account = current_user.accounts.find(params[:account_id])
    @transactions = @account.transactions.paginate(page: params[:page]).order("transaction_date DESC")
  end

  def edit
    @account = current_user.accounts.find(params[:account_id])
    @transaction = @account.transactions.find(params[:id])
  end

  def update
    @account = current_user.accounts.find(params[:account_id])
    @transaction = @account.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to account_transactions_path, account: @account, notice: "The changes were made to transaction"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:budgeted_line_item_id, :amount)
  end
end
