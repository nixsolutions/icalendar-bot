# frozen_string_literal: true

module Commands
  module CreateAppointment
    class ConfirmDayTime < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::SelectTimeEnd
      end

      private

      def handle_call(message, user)
        date = fetch_date(message.text, user)
        send_message(chat_id: message.chat.id, **message(date))
        save_date(date, user)
      end

      def handle_callback(callback, user, args)
        date = fetch_date(args.fetch('hour_min'), user)
        send_message(chat_id: callback.message.chat.id, **message(date))

        save_date(date, user)
      end

      def fetch_date(str, user)
        hour, min = str.split(':').map(&:to_i)
        user.current_appointment.started_at.change(hour: hour, min: min)
      end

      def message(date)
        {
          text: message_text,
          parse_mode: :markdown,
          reply_markup: Keyboards::CreateAppointment::ConfirmDayTime.new(date).call
        }
      end

      def message_text
        <<~MARKDOWN
          #{I18n.t('create_appointment.chose_duration')}
        MARKDOWN
      end

      def save_date(date, user)
        user.current_appointment.update_attributes(started_at: date)
        user.update_state(User::States::CONFIRM_DAY_TIME)
      end
    end
  end
end
