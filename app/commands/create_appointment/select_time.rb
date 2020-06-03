# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectTime < Commands::Base
      private

      CONFIRM_DATE_TIME = 'confirm'

      def handle_callback(callback, args)
        date = DateTime.strptime(args.fetch('day'), '%Q')
        send_message(
          chat_id: callback.message.chat.id,
          text: message(date),
          parse_mode: :markdown,
          reply_markup: time_selection_keyboard(date)
        )
        user = User.find_or_create(message.from)
        Users::SetState.call(user.id, Users::States::SELECT_TIME)
      end

      def time_selection_keyboard(date)
        inline_keyboard(
          [
            button('18:00', CONFIRM_DATE_TIME, day_time: date.change({ hour: 18, min: 0, sec: 0 }).strftime('%Q')),
            button('19:00', CONFIRM_DATE_TIME, day_time: date.change({ hour: 19, min: 0, sec: 0 }).strftime('%Q'))
          ]
        )
      end

      def message(day)
        <<~MARKDOWN
          *——— #{day.strftime('%B %d, %a')} ———*
          Time:
        MARKDOWN
      end
    end
  end
end
