# frozen_string_literal: true

module Commands
  module Keyboards
    class SendAppointment
      include KeyboardHelpers

      def call(appointment)
        inline_keyboard(
          [
            button('Send file', 'send_file', index_number: appointment.index_number)
          ],
          [
            button('Link to ics file (IOS)', nil, url: IcsLinkGenerator.call(appointment))
          ]
        )
      end
    end
  end
end
