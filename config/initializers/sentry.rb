# frozen_string_literal: true

Raven.configuration.silence_ready = true
Raven.configure do |config|
  config.current_environment = ENV.fetch('APP_ENV')
  config.environments = %w[prod dev]
  config.dsn = ENV.fetch('SENTRY_DSN', nil)
end
