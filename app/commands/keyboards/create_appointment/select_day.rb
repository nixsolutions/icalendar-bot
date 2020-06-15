# frozen_string_literal: true

module Commands
  module Keyboards
    module CreateAppointment
      class SelectDay
        include KeyboardHelpers

        CALLBACK_NAME = 'select_time'

        def call
          now = DateTime.now
          inline_keyboard(
            [
              day_button('today', now),
              day_button('tomorrow', now.next_day)
            ]
          )
        end

        private

        def day_button(locale, day_time)
          day = I18n.t("create_appointment.#{locale}")
          button(
            "#{day} #{day_time.strftime('%d of %B')}",
            CALLBACK_NAME,
            day: day_time.strftime('%Q')
          )
        end
      end
    end
  end
end
