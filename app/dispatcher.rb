# frozen_string_literal: true

class Dispatcher
  def initialize(bot)
    @bot = bot
  end

  def call(message)
    case message
    when Telegram::Bot::Types::Message
      dispatch_message(message)
    when Telegram::Bot::Types::CallbackQuery
      dispatch_callback(message)
    else
      dispatch_message(message)
    end
    { statusCode: 200 }
  rescue StandardError
    { statusCode: 200 }
  ensure
    { statusCode: 200 }
  end

  private

  attr_reader :bot

  def dispatch_message(message)
    p 'command name', command_name(message), Commands.class_for(command_name(message))
    handler = Commands.class_for(command_name(message)).new(bot)

    handler.call(message)
  end

  def dispatch_callback(message)
    p 'callback name', callback_name(message), Commands.class_for_callback(callback_name(message))
    handler = Commands.class_for_callback(callback_name(message)).new(bot)

    handler.call(message)
  end

  def callback_name(message)
    JSON.parse(message.data)['command'].to_sym
  end

  def command_name(message)
    message.text&.gsub(/_\d+$/, '').to_sym
  end
end
