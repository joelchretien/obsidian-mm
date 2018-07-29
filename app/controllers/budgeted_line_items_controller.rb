class BudgetedLineItemsController < ApplicationController
  def index
    to_return = current_user.budgeted_line_items
    respond_to do |format|
      format.html { @budgeted_line_items = to_return.paginate(page: params[:page]).order('description')}
      format.json { render json: to_return.search(params[:q])}
    end
  end
end
