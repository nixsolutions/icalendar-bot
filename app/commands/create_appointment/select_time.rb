# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectTime < Commands::Base
      private

      def handle_callback(callback, args)
        date = Date.new(2019, 1, args.fetch('day'))
        send_message(
          chat_id: callback.message.chat.id,
          text: message(date),
          parse_mode: :markdown,
          reply_markup: time_selection_keyboard
        )
      end

      def time_selection_keyboard
        inline_keyboard(
          [
            button('18:00', 'schedule', day: 1),
            button('19:00', 'schedule', day: 2)
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
