# frozen_string_literal: true

require_relative 'system/boot'

def webhook(event:, context:)
  bot = Telegram::Bot::Api.new(ENV.fetch('TELEGRAM_BOT_API_TOKEN'))
  dispatcher = Dispatcher.new(bot)
  message = Telegram::Bot::Types::Message.new(JSON.parse(event['body'])['message'])
  dispatcher.call(message)
end
