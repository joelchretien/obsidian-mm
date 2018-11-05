class DashboardController < ApplicationController
  respond_to :html, :json

  def index
    @account = current_user.accounts.find(params[:account_id])
    transaction_dashboard_service = TransactionReporting::TransactionDashboardService.new(
      @account,
      Date.today - 2.month,
      Date.today + 2.month
    )
    @transaction_dashboard = transaction_dashboard_service.call()
  end
end
