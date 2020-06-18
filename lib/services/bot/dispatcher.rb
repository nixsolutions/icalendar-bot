# frozen_string_literal: true

module Bot
  class Dispatcher < ApplicationService
    attr_reader :message, :bot

    def initialize(bot, message)
      @bot = bot
      @message = message
    end

    def call
      user = User.find_or_create(message.from)
      command_class(message, user).new(bot).call(message, user)
    rescue TypeError, Date::Error
      Commands::Unknown.new(bot).call(message, nil)
    end

    private

    def command_class(message, user)
      case message
      when Telegram::Bot::Types::Message
        message_class(message, user)
      when Telegram::Bot::Types::CallbackQuery
        callback_class(message)
      else
        Commands::Unknown
      end
    end

    def message_class(message, user)
      Bot::StepHandler.call(message, user)
    end

    def callback_class(message)
      command = MultiJson.load(message.data)['command'].to_sym
      Commands.class_for_callback(command)
    end
  end
end
