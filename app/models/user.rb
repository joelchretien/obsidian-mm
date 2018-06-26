class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :registerable, :confirmable

  has_many :transactions, dependent: :destroy
end
