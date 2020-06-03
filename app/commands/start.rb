# frozen_string_literal: true

module Commands
  class Start < Base
    private

    def handle_call(message)
      send_message(
        chat_id: message.chat.id,
        text: I18n.t('welcome.text'),
        parse_mode: :markdown,
        reply_markup: Keyboards::MainReplyKeyboard.new.call
      )
      User.set_state(message.from, :start)
    end
  end
end
