# frozen_string_literal: true

require 'forwardable'

module Commands
  class Base
    extend Forwardable
    include KeyboardHelpers
    # include ContextHelpers

    attr_reader :api

    def initialize(api, **_deps)
      @api = api
      # super(deps)
    end

    def call(message)
      case message
      when Telegram::Bot::Types::Message
        handle_call(message)
      when Telegram::Bot::Types::CallbackQuery
        args = JSON.parse(message.data)['args']
        handle_callback(message, args)
      end
    end

    private

    def_delegators :api, :send_message, :edit_message_text, :send_location,
                   :delete_message, :send_photo, :answer_callback_query

    def handle_call(_message)
      raise NotImplementedError, "you have to implement #{self.class.name}#handle_call"
    end

    def handle_callback(_callback, _args)
      raise NotImplementedError, "you have to implement #{self.class.name}#handle_callback"
    end
  end
end
