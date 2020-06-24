# frozen_string_literal: true

module Commands
  module Keyboards
    module CreateAppointment
      class ConfirmDayTime
        include KeyboardHelpers

        CALLBACK_NAME = 'select_time_end'

        def initialize(date)
          @date = date
        end

        def call
          inline_keyboard(buttons)
        end

        private

        def buttons
          [15, 30, 60, 90].map { |min| button("#{min} min", CALLBACK_NAME, appointment_duration: min) }
        end
      end
    end
  end
end
