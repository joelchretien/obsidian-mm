class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable

  has_many :transactions, dependent: :destroy
  has_many :budgeted_line_items, dependent: :destroy
end
