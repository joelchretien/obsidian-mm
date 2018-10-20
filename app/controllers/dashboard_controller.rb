class DashboardController < ApplicationController
  respond_to :html, :json

  def index
    @account = current_user.accounts.find(params[:account_id])
    transaction_timeline_service = TransactionReporting::TransactionTimeline.new(@account, Date.today - 1.month, Date.today + 1.month)
    @transaction_timeline = transaction_timeline_service.call()
  end
end
