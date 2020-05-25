# frozen_string_literal: true

module Commands
  class Start < Base
    private

    def welcome_text
      I18n.t('welcome.text')
    end

    def handle_call(message)
      user = Users::FindOrCreate.call(message.from)
      Users::SetState.call(user.id, Users::States::START)
      send_message(
        chat_id: message.chat.id,
        text: welcome_text,
        parse_mode: :markdown,
        reply_markup: Keyboards::MainReplyKeyboard.new.call
      )
    end
  end
end
