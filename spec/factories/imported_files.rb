FactoryBot.define do
  factory :imported_file do
    sequence(:filename) { |n| "FileName#{n}" }
  end
end
