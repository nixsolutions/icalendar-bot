# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectTimeEnd < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::WriteSummary
      end

      private

      def handle_callback(callback, user, args)
        duration = args.fetch('appointment_duration')
        started_at = user.current_appointment.started_at
        ended_at = started_at + duration.to_i.minutes
        send_message(chat_id: callback.message.chat.id, **message(started_at, ended_at))

        save_date_end(ended_at, user)
      end

      def message(started_at, ended_at)
        {
          text: message_text(started_at, ended_at),
          parse_mode: :markdown
        }
      end

      def message_text(started_at, ended_at)
        <<~MARKDOWN
          *——— ⌚️#{started_at.strftime('%b %-d, %H:%M')} ———*
          ⌛ #{I18n.t('create_appointment.meeting_ended')}: #{ended_at.strftime('%H:%M')}

          #{I18n.t('create_appointment.summary')}
        MARKDOWN
      end

      def save_date_end(date, user)
        user.current_appointment.update_attributes(ended_at: date)
        user.update_state(User::States::SELECT_TIME_END)
      end
    end
  end
end
