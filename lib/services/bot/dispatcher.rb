# frozen_string_literal: true

module Bot
  class Dispatcher < ApplicationService
    attr_reader :message

    def initialize(bot, message)
      @bot = bot
      @message = message
    end

    def call
      case message
      when Telegram::Bot::Types::Message
        dispatch_message(message)
      when Telegram::Bot::Types::CallbackQuery
        dispatch_callback(message)
      end
    end

    private

    attr_reader :bot

    def dispatch_message(message)
      command_class = Commands.class_for(command_name(message))
      return Bot::StepHandler.call(message) if command_class == Commands::FALLBACK_COMMAND_CLASS

      handler = command_class.new(bot)

      handler.call(message)
    end

    def dispatch_callback(message)
      handler = Commands.class_for_callback(callback_name(message)).new(bot)

      handler.call(message)
    end

    def command_name(message)
      message.text&.gsub(/_\d+$/, '')&.to_sym
    end

    def callback_name(message)
      JSON.parse(message.data)['command'].to_sym
    end
  end
end
