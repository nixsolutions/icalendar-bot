# frozen_string_literal: true

module Commands
  module CreateAppointment
    class WriteDescription < Commands::Base
      private

      def handle_call(message, user)
        user.current_appointment.update_attributes(description: message.text)
        appointment = Appointment.find(user.appointment_context, consistent_read: true)
        send_message(chat_id: message.chat.id, **message(appointment))

        user.update_state(User::States::WRITE_DESCRIPTION)
        appointment.update_attributes(status: Appointment::COMPLETE)
      end

      def message(appointment)
        {
          text: message_text(appointment),
          parse_mode: :markdown,
          reply_markup: Keyboards::SendAppointment.new.call(appointment)
        }
      end

      def message_text(appointment)
        <<~MARKDOWN
          ⌚: *——— #{appointment.started_at.strftime('%B %d, %a, %H:%M')} ———*
          ⌛: #{I18n.t('create_appointment.meeting_ended')}: #{appointment.ended_at.strftime('%H:%M')}
          ❗: #{appointment.summary}
          📝: #{appointment.description}
        MARKDOWN
      end
    end
  end
end
