class CreateBudgetedLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budgeted_line_items do |t|
      t.text :description, null: false
      t.integer :amount_cents, null: false
      t.integer :recurrence, null: false
      t.integer :recurrence_multiplier, null: false
      t.references :user, foreign_key: true, null: false
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end
  end
end
