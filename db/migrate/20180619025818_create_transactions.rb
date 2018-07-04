class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :description, null: false
      t.integer :amount_cents, null: false
      t.date :transaction_date, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
