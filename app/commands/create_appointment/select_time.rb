# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectTime < Commands::Base
      private

      def handle_call(message)
        send_message(
          chat_id: message.chat.id,
          text: I18n.t('create_appointment.choose_day'),
          reply_markup: day_selection_keyboard
        )
      end

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

      def day_selection_keyboard
        inline_keyboard(
          [
            button("Today #{Time.now.to_date.strftime('%d of %B, %Y')}", 'schedule', day: 2),
            button("Tomorrow #{Time.now.to_date.next_day.strftime('%d of %B, %Y')}", 'schedule', day: 1)
          ]
        )
      end

      def message(confday)
        <<~MARKDOWN
          *——— #{confday.strftime('%B %d, %a')} ———*
          Time:
        MARKDOWN
      end
    end
  end
end
