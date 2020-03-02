# frozen_string_literal: true

module Commands
  class Unknown < Base
    private

    def handle_call(message)
      send_message(
        chat_id: message.chat.id,
        text: message_text
      )
    end

    def handle_callback(callback, _args)
      answer_callback_query(
        callback_query_id: callback.id,
        text: callback_text
      )
    end

    def callback_text
      I18n.t('unknown.callback_text')
    end

    def message_text
      I18n.t('unknown.text')
    end
  end
end
