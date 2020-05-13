# frozen_string_literal: true

require 'uri'
require 'net/http'
TELEGRAM_URL = "https://api.telegram.org/bot"

desc "Set telegram webhook"
task :set_webhook, :my_bot_token, :url_to_send_updates_to do |t, args|
  my_bot_token = args[:my_bot_token]
  url_to_send_updates_to = args[:url_to_send_updates_to]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/setWebhook?url=#{url_to_send_updates_to}")
  res = Net::HTTP.get(uri)
  puts res
end

desc "Remove telegram webhook"
task :remove_webhook, :my_bot_token do |t, args|
  my_bot_token = args[:my_bot_token]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/setWebhook?remove")
  res = Net::HTTP.post(uri,"{}")
  puts res
end

desc "Clear telegram request queue"
task :clear_requests, :my_bot_token do |t, args|
  my_bot_token = args[:my_bot_token]
  uri = URI("#{TELEGRAM_URL}#{my_bot_token}/getUpdates?offset=54232484")
  res = Net::HTTP.get(uri)
  puts res
end
