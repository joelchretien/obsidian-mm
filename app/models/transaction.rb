class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :budgeted_line_item, required: false
  validates :user, presence: true
  validates :description, presence: true
  validates :transaction_date, presence: true
  monetize :amount_cents
  validates :amount_cents, presence: true

  self.per_page = 50
end
