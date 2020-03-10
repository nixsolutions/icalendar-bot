# frozen_string_literal: true

require 'uri'
require 'net/http'

task :default do
  my_bot_token = ''
  url_to_send_updates_to = ''
  uri = URI("https://api.telegram.org/bot#{my_bot_token}/setWebhook?url=#{url_to_send_updates_to}")
  res = Net::HTTP.get(uri)
  puts res
end
