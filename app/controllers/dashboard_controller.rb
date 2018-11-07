class DashboardController < ApplicationController
  respond_to :html, :json

  def index
    @account = current_user.accounts.find(params[:account_id])
    @transaction_dashboard = TransactionReporting::DashboardQuery.new(
      @account,
      Date.today - 2.month,
      Date.today + 2.month
    ).call
  end
end
