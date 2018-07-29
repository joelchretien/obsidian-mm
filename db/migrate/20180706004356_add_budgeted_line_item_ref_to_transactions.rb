class AddBudgetedLineItemRefToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :budgeted_line_item, foreign_key: true
  end
end
