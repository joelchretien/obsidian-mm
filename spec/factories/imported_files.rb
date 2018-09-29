FactoryBot.define do
  sequence(:filename) { |n| "FileName#{n}" }

  factory :imported_file do
    filename
    account
  end
end
