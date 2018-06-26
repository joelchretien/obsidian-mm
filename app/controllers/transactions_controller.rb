class TransactionsController < ApplicationController
  def index
    @transactions = current_user.transactions.paginate(page: params[:page]).order('transaction_date DESC')
  end
end
