class AddBalanceToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :balance_cents, :integer, nullable: false

    create_table :user_entered_balances do |t|
      t.references :account, unique: true
      t.references :transaction
      t.integer :balance_cents

      t.timestamps
    end
  end
end
