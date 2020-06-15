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
              button('18:00', CALLBACK_NAME, day_time: date.change({ hour: 18 }).strftime('%Q')),
              button('19:00', CALLBACK_NAME, day_time: date.change({ hour: 19 }).strftime('%Q'))
            ]
          )
        end
      end
    end
  end
end
