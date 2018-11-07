module TransactionImport
  class BudgetAssigner
    attr_accessor :transactions, :budgeted_line_items, :save

    def initialize(transactions:, budgeted_line_items:, save:)
      @transactions = transactions
      @budgeted_line_items = budgeted_line_items
      @save = save
    end

    def call
      @transactions.each do |transaction|
        matching_items = @budgeted_line_items.find_all do |item|
          item.transaction_descriptions == transaction.description &&
            item.start_date <= transaction.transaction_date &&
            (item.end_date.nil? || item.end_date >= transaction.transaction_date)
        end
        if !matching_items.empty?
          transaction.budgeted_line_item = matching_items.first
          if save
            transaction.save
          end
        end
      end
    end
  end
end
