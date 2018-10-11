class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :budgeted_line_items, dependent: :destroy
  has_many :imported_files, dependent: :destroy

  validates :name, presence: true
  validates :import_configuration_options, presence: true

  def transactions_for_last_day
    last_transaction = transactions.order("transaction_date DESC").first
    if last_transaction.nil?
      []
    else
      last_day_transactions = transactions.where(transaction_date: last_transaction.transaction_date)
      last_day_transactions
    end
  end
end
