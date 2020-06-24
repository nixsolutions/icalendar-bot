# frozen_string_literal: true

ENV['APP_ENV'] ||= 'test'

require_relative '../system/boot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  config.after(:each) do
    DynamoidReset.all
  end
  config.disable_monkey_patching!
  config.expose_dsl_globally = true
  config.warnings = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
