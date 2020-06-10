# frozen_string_literal: true

require_relative '../system/boot'

class WebhookHandler
  def self.call(event:, context:)
    bot = Telegram::Bot::Api.new(ENV.fetch('TELEGRAM_BOT_API_TOKEN'))
    data = MultiJson.load(event['body'])
    update = Telegram::Bot::Types::Update.new(data)
    message = update.current_message
    dispatch(bot, message)
  end

  def self.dispatch(bot, message)
    Bot::Dispatcher.new(bot, message).call
    { statusCode: 200 }
  rescue StandardError => e
    puts "Error during processing: #{$ERROR_INFO}"
    puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
    Raven.capture_exception(e)
    { statusCode: 200 }
  ensure
    { statusCode: 200 }
  end
end
