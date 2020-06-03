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
        User.set_state(message.from, :select_day)
      end

      def day_selection_keyboard
        now = DateTime.now
        inline_keyboard(
          [
            button("Today #{now.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: now.strftime('%Q')),
            button("Tomorrow #{now.next_day.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: now.next_day.strftime('%Q'))
          ]
        )
      end
    end
  end
end
