class TransactionsController < ApplicationController
  def index
    @transactions = current_user.transactions.paginate(page: params[:page]).order('transaction_date DESC')
  end

  def edit
    @transaction = current_user.transactions.find(params[:id])
  end

  def update
    @transaction = current_user.transactions.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transactions_path, notice: 'The changes were made to transaction'
    end
  end

    private
    def transaction_params
      params.require(:transaction).permit(:budgeted_line_item_id)
    end
end
