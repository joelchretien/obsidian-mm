FactoryBot.define do
  sequence(:source_file) { |n| "FileName#{n}" }
  sequence(:last_balance) { |n| n }

  factory :import_file_request do
    source_file
    account
    last_balance
  end
end
