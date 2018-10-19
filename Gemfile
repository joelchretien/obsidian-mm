source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.1"
gem "rails", "~> 5.2.0"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.1.2"
gem "font-awesome-rails"
gem "select2-rails"
gem "jquery-rails"
gem "dotenv-rails", groups: [:development, :test]
gem "devise"
gem "will_paginate"
gem "will_paginate-bootstrap4"
gem "money-rails", "~>1"
gem "responders", "~> 2.0"
gem "activerecord-import"
gem "chartkick"
gem "groupdate"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "pry-byebug"
  gem "pry-rails"
  gem "pry-rescue"
  gem "pry-stack_explorer"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "factory_bot_rails"
  gem "capybara"
  gem "capybara-webkit"
  gem "capybara-screenshot"
  gem "rails-controller-testing"
  gem "email_spec"
  gem "rubocop-rails_config", require: false
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "database_cleaner"
  gem "simplecov", require: false
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
