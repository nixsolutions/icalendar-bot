# frozen_string_literal: true

require 'dynamoid'
# require all models
Dir[File.expand_path 'lib/models/*.rb'].each { |f| require_relative f }

Dynamoid.configure do |config|
  config.namespace = 'dynamoid_app_development'
  config.endpoint = 'http://localhost:8000'
end

Dynamoid.included_models.each { |m| m.create_table(sync: true) }
