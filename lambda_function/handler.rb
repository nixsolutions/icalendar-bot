# frozen_string_literal: true
require "aws-sdk-s3"

module LambdaFunction
  class Handler
    def self.process(event:, context:)
      Telegram::Bot::Client.run(TELEGRAM_TOKEN) do |bot|
        bot.listen do |rqst|
          Thread.start(rqst) do |rqst|
            options = { bot: bot, message: rqst }
            begin
              # logger.debug "@#{message.from.username}: #{message.text}"
              Message::Responder.new(options).respond
            rescue
              p ':('
            end
          end
        end
      end
    end
  end
end
