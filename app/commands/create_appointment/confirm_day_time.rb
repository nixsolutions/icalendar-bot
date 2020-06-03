# frozen_string_literal: true

module Commands
  module CreateAppointment
    class ConfirmDayTime < Commands::Base
      private

      def handle_callback(callback, args)
        date_time = DateTime.strptime(args.fetch('day_time'), '%Q')
        send_message(
          chat_id: callback.message.chat.id,
          text: message(date_time),
          parse_mode: :markdown
        )
      end

      def message(day_time)
        <<~MARKDOWN
          *——— ⌚️#{day_time.strftime('%b %-d, %H:%M')} ———*
          #{I18n.t('create_appointment.subject')}
        MARKDOWN
      end
    end
  end
end
