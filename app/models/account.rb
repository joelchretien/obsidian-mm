class Account < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy
  has_many :budgeted_line_items, dependent: :destroy
  has_many :imported_files, dependent: :destroy

  validates :name, presence: true
  validates :import_configuration_options, presence: true
end
