class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :amount
      t.date :transaction_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
