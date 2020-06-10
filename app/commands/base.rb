# frozen_string_literal: true

require 'forwardable'

module Commands
  class Base
    extend Forwardable
    include KeyboardHelpers

    attr_reader :api

    def initialize(api)
      @api = api
    end

    def call(message, user)
      case message
      when Telegram::Bot::Types::Message
        handle_call(message, user)
      when Telegram::Bot::Types::CallbackQuery
        args = MultiJson.load(message.data)['args']
        handle_callback(message, user, args)
      end
    end

    private

    def_delegators :api, :send_message, :edit_message_text, :send_location,
                   :delete_message, :send_document, :answer_callback_query

    def available_transition
      nil
    end

    def handle_call(_message, _user)
      raise NotImplementedError, "you have to implement #{self.class.name}#handle_call"
    end

    def handle_callback(_callback, _user, _args)
      raise NotImplementedError, "you have to implement #{self.class.name}#handle_callback"
    end
  end
end
