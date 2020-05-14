# frozen_string_literal: true

ENV['APP_ENV'] ||= 'test'

require_relative '../system/boot'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expose_dsl_globally = true
  config.warnings = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
