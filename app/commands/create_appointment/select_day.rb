# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectDay < Commands::Base
      private

      CALLBACK_NAME = 'select_time'

      def handle_call(message)
        send_message(
          chat_id: message.chat.id,
          text: I18n.t('create_appointment.choose_day'),
          reply_markup: day_selection_keyboard
        )
      end

      def day_selection_keyboard
        inline_keyboard(
          [
            button("Today #{Time.now.to_date.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: 2),
            button("Tomorrow #{Time.now.to_date.next_day.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: 1)
          ]
        )
      end
    end
  end
end
