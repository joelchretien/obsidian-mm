MoneyRails.configure do |config|
  config.default_currency = :usd
end

Money.locale_backend = :currency
