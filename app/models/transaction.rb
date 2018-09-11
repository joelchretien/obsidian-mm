class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :budgeted_line_item, required: false
  validates :account, presence: true
  validates :description, presence: true
  validates :transaction_date, presence: true
  monetize :amount_cents
  validates :amount_cents, presence: true
  belongs_to :imported_file
  validates :imported_file, presence: true

  self.per_page = 50

  def user
    account.user
  end

  def is_duplicate(transaction)
    description == transaction.description &&
      transaction_date == transaction.transaction_date &&
      amount_cents == transaction.amount_cents
  end
end
