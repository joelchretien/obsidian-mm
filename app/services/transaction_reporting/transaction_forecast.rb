module TransactionReporting
  class TransactionForecast
    attr_reader :account, :duration_to_forecast

    def initialize(account, duration_to_forecast)
      @account = account
      @duration_to_forecast = duration_to_forecast
    end

    def call
      # budgeted_line_items = @account.budgeted_line_items
      # forecasted_transactions_service
      # latest_transactions_be_descriptions_service = LatestTransactionsByDescriptions.new(@account)
      # latest_transactions_by_description = latest_transactions_be_descriptions_service.call()
    end
  end
end
