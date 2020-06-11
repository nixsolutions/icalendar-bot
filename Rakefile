# frozen_string_literal: true

require 'uri'
require 'net/http'
TELEGRAM_URL = 'https://api.telegram.org/bot'

desc 'Set telegram webhook'
task :set_webhook, :my_bot_token, :url_to_send_updates_to do |_t, args|
  my_bot_token = args[:my_bot_token]
  url_to_send_updates_to = args[:url_to_send_updates_to]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/setWebhook?url=#{url_to_send_updates_to}")
  res = Net::HTTP.get(uri)
  puts res
end

desc 'Remove telegram webhook'
task :remove_webhook, :my_bot_token do |_t, args|
  my_bot_token = args[:my_bot_token]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/setWebhook?remove")
  res = Net::HTTP.post(uri, '{}')
  puts res
end

desc 'Clear telegram request queue'
task :clear_requests, :my_bot_token do |_t, args|
  my_bot_token = args[:my_bot_token]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/getUpdates?offset=54232484")
  res = Net::HTTP.get(uri)
  puts res
end

namespace :db do
  task :create, :env do |_t, args|
    env = args[:env]
    ENV['APP_ENV'] = env
    require_relative 'system/boot'
    Dynamoid.included_models.each { |m| m.create_table(sync: true) }
    p 'success'
  end

  task :drop, :env do |_t, args|
    env = args[:env]
    ENV['APP_ENV'] = env
    raise if env == 'prod'

    require_relative 'system/boot'
    DynamoidReset.all
    p 'success'
  end
end
