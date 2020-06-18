# frozen_string_literal: true

module Commands
  module CreateAppointment
    class SendAppointment < Commands::Base
      def handle_callback(callback, user, args)
        appointment = user.appointments.where(index_number: args.fetch('index_number')).first

        send_document(
          chat_id: callback.message.chat.id,
          text: 'file:',
          document: IcsFileGenerator.call(appointment)
        )
      end
    end
  end
end
