module TransactionReporting
  class DashboardQuery
    attr_reader :account, :start_date, :end_date

    def initialize(account, start_date, end_date)
      @account = account
      @start_date = start_date
      @end_date = end_date
    end

    def call
      @dashboard = {}
      @dashboard[:timeline_items] = TimelineQuery.new(@account, @start_date, @end_date).call
      @dashboard[:chart_data] = ChartDataQuery.new(@dashboard[:timeline_items]).call
      @dashboard
    end
  end
end
