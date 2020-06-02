# frozen_string_literal: true

require 'system/boot'

def webhook(event:, context:)
  bot = Telegram::Bot::Api.new(ENV.fetch('TELEGRAM_BOT_API_TOKEN'))
  dispatcher = Dispatcher.new(bot)
  p event['body']
  data = JSON.parse(event['body'])
  update = Telegram::Bot::Types::Update.new(data)
  message = update.current_message
  dispatcher.call(message)
end
