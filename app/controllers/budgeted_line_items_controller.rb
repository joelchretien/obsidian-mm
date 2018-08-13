class BudgetedLineItemsController < ApplicationController
  def index
    @account = current_user.accounts.find(params[:account_id])
    to_return = @account.budgeted_line_items
    respond_to do |format|
      format.html { @budgeted_line_items = to_return.paginate(page: params[:page]).order('description')}
      format.json { render json: to_return.search(params[:q])}
    end
  end
end
