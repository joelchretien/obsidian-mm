module TransactionReporting
  class ChartDataService
    attr :timeline_items

    def initialize(timeline_items)
      @timeline_items = timeline_items
    end

    def call
      grouped_by_day = @timeline_items.group_by { |item| item.transaction_date }
      last_balance_each_day = grouped_by_day.map { |item| item[1].first }
      chart_data = {}
      last_balance_each_day.each do |item|
        chart_data[item.transaction_date] = item.balance.to_f
      end
      chart_data
    end
  end
end
