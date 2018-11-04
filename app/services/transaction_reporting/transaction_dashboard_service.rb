module TransactionReporting
  class TransactionDashboardService
    attr_reader :account

    def initialize(account)
      @account = account
    end

    def call
      @dashboard = {}
      @dashboard.timeline_items = TransactionTimeline.new(account).call
      @dashboard.chart_data = ChartDataService.new(@dashboard.timeline_items).call

    end
  end
end
