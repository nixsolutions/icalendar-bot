# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectTime < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::ConfirmDayTime
      end

      private

      def handle_call(message, user)
        day, month = message.text.split('.').map(&:to_i)
        date = DateTime.now.change({ day: day, month: month })
        send_message(chat_id: message.chat.id, **message(date))

        save_date(date, user)
      end

      def handle_callback(callback, user, args)
        date = DateTime.strptime(args.fetch('day'), '%Q')
        send_message(chat_id: callback.message.chat.id, **message(date))

        save_date(date, user)
      end

      def save_date(date, user)
        user.current_appointment.update_attributes(started_at: date)
        user.update_state(User::States::SELECT_TIME)
      end

      def message(date)
        {
          text: message_text(date),
          parse_mode: :markdown,
          reply_markup: Keyboards::CreateAppointment::SelectTime.new(date).call
        }
      end

      def message_text(day)
        <<~MARKDOWN
          *——— #{day.strftime('%B %d, %a')} ———*
          #{I18n.t('create_appointment.select_time')}:
        MARKDOWN
      end
    end
  end
end
