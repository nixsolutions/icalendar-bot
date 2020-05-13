# frozen_string_literal: true

module Commands
  class Time < Base
    private

    def welcome_text
      I18n.t('create_appointment.time')
    end

    def handle_call(message)
      send_message(
          chat_id: message.chat.id,
          text: welcome_text,
          parse_mode: :markdown,
          reply_markup: Keyboards::MainReplyKeyboard.new.call
      )
    end
  end
end
