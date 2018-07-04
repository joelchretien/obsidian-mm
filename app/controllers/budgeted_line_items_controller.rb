class BudgetedLineItemsController < ApplicationController
  def index
    @budgeted_line_items = current_user.budgeted_line_items.paginate(page: params[:page]).order('description')
  end
end
