class AddTransactionDescriptionsToBudgetedLineItems < ActiveRecord::Migration[5.2]
  def change
    add_column :budgeted_line_items, :transaction_descriptions, :text
  end
end
