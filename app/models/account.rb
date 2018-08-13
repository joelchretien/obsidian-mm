class Account < ApplicationRecord
  belongs_to :user
  
  has_many :transactions, dependent: :destroy
  has_many :budgeted_line_items, dependent: :destroy

  validates :name, presence: true
end
