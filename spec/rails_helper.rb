require 'spec_helper'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'action_mailer'
require 'email_spec'
require 'email_spec/rspec'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :active_record
    with.library :active_model
    with.library :action_controller
    with.library :rails
  end
end

require "support/controller_helpers"
RSpec.configure do |config|
  config.include Warden::Test::Helpers
  # config.include Devise::TestHelpers, :type => :controller
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include ControllerHelpers, :type => :controller
end
