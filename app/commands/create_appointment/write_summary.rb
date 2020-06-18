# frozen_string_literal: true

module Commands
  module CreateAppointment
    class WriteSummary < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::WriteDescription
      end

      private

      def handle_call(message, user)
        send_message(
          chat_id: message.chat.id,
          text: message_text,
          parse_mode: :markdown
        )
        save_summary(message.text, user)
      end

      def message_text
        <<~MARKDOWN
          #{I18n.t('create_appointment.description')}
        MARKDOWN
      end

      def save_summary(summary, user)
        user.current_appointment.update_attributes(summary: summary)
        user.update_state(User::States::WRITE_SUMMARY)
      end
    end
  end
end
