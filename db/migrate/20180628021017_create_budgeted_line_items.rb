class CreateBudgetedLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budgeted_line_items do |t|
      t.text :description
      t.float :amount
      t.integer :recurrence
      t.integer :recurrence_multiplier
      t.references :user, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
