# frozen_string_literal: true

module Commands
  module CreateAppointment
    class ConfirmDayTime < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::WriteSummary
      end

      private

      def handle_call(message, user)
        hour, min = message.text.split(':').map(&:to_i)
        date = user.current_appointment.started_at.change(hour: hour, min: min)
        send_message(chat_id: message.chat.id, **message(date))
        save_date(date, user)
      end

      def handle_callback(callback, user, args)
        date = DateTime.strptime(args.fetch('day_time'), '%Q')
        send_message(chat_id: callback.message.chat.id, **message(date))

        save_date(date, user)
      end

      def message(date)
        {
          text: message_text(date),
          parse_mode: :markdown
        }
      end

      def message_text(day_time)
        <<~MARKDOWN
          *——— ⌚️#{day_time.strftime('%b %-d, %H:%M')} ———*
          #{I18n.t('create_appointment.summary')}
        MARKDOWN
      end

      def save_date(date, user)
        user.current_appointment.update_attributes(started_at: date)
        user.update_state(User::States::CONFIRM_DAY_TIME)
      end
    end
  end
end
