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
        user = User.find_or_create(message.from)
        Users::SetState.call(user.id, Users::States::SELECT_DAY)
      end

      def day_selection_keyboard
        now = DateTime.now
        p  now.strftime('%Q')
        inline_keyboard(
          [
            button("Today #{now.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: now.strftime('%Q')),
            # button("Tomorrow #{now.next_day.strftime('%d of %B, %Y')}", CALLBACK_NAME, day: now.next_day.strftime('%Q'))
          ]
        )
      end
    end
  end
end
