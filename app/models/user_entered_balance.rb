class UserEnteredBalance < ApplicationRecord
  belongs_to :account
  validates :account, presence: true
  belongs_to :balance_transaction, foreign_key: "transaction_id", class_name: "Transaction"
  validates :balance_transaction, presence: true
  monetize :balance_cents
  validates :balance_cents, presence: true
end
