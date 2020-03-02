# frozen_string_literal: true

require 'dynamoid'
# require all models
Dir[File.expand_path 'lib/models/*.rb'].each { |f| require_relative f }

Dynamoid.configure do |config|
  config.access_key = ENV['AWS_ACCESS_KEY_ID']
  config.secret_key = ENV['AWS_SECRET_ACCESS_KEY']
  config.region = ENV['AWS_REGION']
end

Dynamoid.included_models.each { |m| m.create_table(sync: true) }
