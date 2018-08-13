class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.text :name

      t.timestamps
    end

    change_table :transactions do |t|
      t.references :account, foreign_key: true
      t.remove :user_id
    end

    change_table :budgeted_line_items do |t|
      t.references :account, foreign_key: true
      t.remove :user_id
    end
  end
end
