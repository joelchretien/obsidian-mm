require 'json'
FactoryBot.define do
  factory :account do
    user
    sequence(:name) { |n| "account#{n}" }
    import_configuration_options { { hello: "yo" } }.to_json
  end
end
