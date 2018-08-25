class ImportedFile < ApplicationRecord
  belongs_to :account
  has_many :transactions
  has_one_attached :source_file
end
