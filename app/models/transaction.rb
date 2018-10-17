class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :budgeted_line_item, required: false
  has_one :user_entered_balance, dependent: :destroy
  validates :account, presence: true
  validates :description, presence: true
  validates :transaction_date, presence: true
  monetize :amount_cents
  validates :amount_cents, presence: true
  belongs_to :imported_file
  validates :imported_file, presence: true
  monetize :balance_cents
  validates :balance_cents, presence: true
  scope :between_dates, -> (start_date, end_date) { where("transaction_date between ? and ?", start_date, end_date) }

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
