# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SelectDay < Commands::Base
      def self.available_transition
        Commands::CreateAppointment::SelectTime
      end

      private

      def handle_call(message, user)
        send_message(
          chat_id: message.chat.id,
          text: I18n.t('create_appointment.choose_day'),
          reply_markup: Keyboards::CreateAppointment::SelectDay.new.call
        )
        appointment = Appointment.find_or_create_draft_for_user(user)
        user.update_attributes(appointment_context: appointment.id, bot_status: User::States::SELECT_DAY)
      end
    end
  end
end
