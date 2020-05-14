# frozen_string_literal: true

# require all models
Dir[File.expand_path 'lib/models/*.rb'].each { |f| require_relative f }
app_name = ENV.fetch('APP_NAME')
app_env = ENV.fetch('APP_ENV')
Dynamoid.configure do |config|
  config.namespace = "#{app_name}_#{app_env}"
  config.endpoint = 'http://localhost:8000' if app_env == 'test'
end

module DynamoidReset
  def self.all
    Dynamoid.adapter.list_tables.each do |table|
      Dynamoid.adapter.delete_table(table) if /^#{Dynamoid::Config.namespace}/.match?(table)
    end
    Dynamoid.adapter.tables.clear
    Dynamoid.included_models.each { |m| m.create_table(sync: true) }
  end
end
