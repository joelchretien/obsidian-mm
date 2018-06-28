class TransactionsController < ApplicationController
  def index
    all_transactions = current_user.transactions
    @transactions = all_transactions.paginate(page: params[:page]).order('transaction_date DESC')
  end
end
