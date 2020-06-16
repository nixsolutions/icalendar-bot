# frozen_string_literal: true

module Commands
  module Keyboards
    module CreateAppointment
      class SelectTime
        include KeyboardHelpers
        attr_reader :date

        CALLBACK_NAME = 'confirm_day_time'

        def initialize(date)
          @date = date
        end

        def call
          inline_keyboard(
            [
              button('18:00', CALLBACK_NAME, hour_min: date.change({ hour: 18, min: 0 }).strftime('%H:%M')),
              button('19:00', CALLBACK_NAME, hour_min: date.change({ hour: 19, min: 0 }).strftime('%H:%M'))
            ]
          )
        end
      end
    end
  end
end
