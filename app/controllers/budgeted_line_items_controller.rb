class BudgetedLineItemsController < ApplicationController
  respond_to :html, :json

  def index
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_items = @account.budgeted_line_items.paginate(page: params[:page]).order('description')
  end

  def new
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_item = BudgetedLineItem.new
    respond_modal_with @budgeted_line_item
  end

  def edit
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_item = @account.budgeted_line_items.find(params[:id])
    respond_modal_with @budgeted_line_item
  end

  def create
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_item = BudgetedLineItem.new(budgeted_line_item_params)
    @budgeted_line_item.account = @account
    @budgeted_line_item.save
    respond_modal_with @budgeted_line_item, location: account_budgeted_line_items_path(@account)
  end

  def update
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_item = @account.budgeted_line_items.find(params[:id])
    @budgeted_line_item.update(budgeted_line_item_params)
    respond_modal_with @budgeted_line_item, location: account_budgeted_line_items_path(@account, @budgeted_line_item)
  end

  def destroy
    @account = current_user.accounts.find(params[:account_id])
    @budgeted_line_item = @account.budgeted_line_items.find(params[:id])
    @budgeted_line_item.destroy
    redirect_to account_budgeted_line_items_path(@account)
  end

  private

  def budgeted_line_item_params
    params.require(:budgeted_line_item).permit(:description, :amount, :recurrence, :recurrence_multiplier, :start_date)
  end
end
