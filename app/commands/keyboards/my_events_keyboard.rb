# frozen_string_literal: true

module Commands
  class MyEventsKeyboards
    include KeyboardHelpers

    def call(user)
      reply_keyboard(
        appointments_buttons(user)
      )
    end

    private

    def appointments_buttons(user)
      user.appointments.where(status: Appointment::COMPLETE)
    end
  end
end
