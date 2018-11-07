class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions, -> { order(transaction_date: :desc, id: :desc) }, dependent: :destroy
  has_one :user_entered_balance, dependent: :destroy
  has_many :budgeted_line_items, dependent: :destroy
  has_many :imported_files, dependent: :destroy

  validates :name, presence: true
  validates :import_configuration_options, presence: true

  def last_transaction
    @last_transaction ||= transactions.first
  end

  def transactions_for_last_day
    return [] if last_transaction.nil?
    transactions.where(transaction_date: last_transaction.transaction_date)
  end
end
