# frozen_string_literal: true

Dir[File.expand_path 'lib/models/*.rb'].each { |f| require_relative f }
Dynamoid.configure do |config|
  config.namespace = "#{ENV.fetch('APP_NAME')}_#{ENV.fetch('APP_ENV')}"
  config.endpoint = ENV.fetch('DYNAMO_DB_URL', nil)
end

Dynamoid.logger.level = Logger::FATAL

module DynamoidReset
  def self.all
    Dynamoid.adapter.list_tables.each do |table|
      Dynamoid.adapter.delete_table(table) if /^#{Dynamoid::Config.namespace}/.match?(table)
    end
    Dynamoid.adapter.tables.clear
    Dynamoid.included_models.each { |m| m.create_table(sync: true) }
  end
end
