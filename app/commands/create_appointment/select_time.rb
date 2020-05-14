# frozen_string_literal: true
require 'date'
require 'time'
require 'pry'
module Commands::CreateAppointment
  class Time < Commands::Base
    private

    CONFDAY_SELECTION_KEYBOARD = inline_keyboard(
        [
            button('June 1, Sat', 'schedule', confday: 1),
            button('June 2, Sun', 'schedule', confday: 2)
        ]
    )

    def day_selection_keyboard
      binding.pry
      inline_keyboard(
        [
            button("Today #{Time.now.to_date.strftime('%d of %B, %Y')}", 'schedule', day: 2),
            button("Tomorrow #{Time.now.to_date.next_day.strftime('%d of %B, %Y')}", 'schedule', day: 1)
        ]
      )
    end

    def handle_call(message)
      send_message(
          chat_id: message.chat.id,
          text: I18n.t('create_appointment.choose_day'),
          reply_markup: CONFDAY_SELECTION_KEYBOARD
      )
    end

    def handle_callback(callback, args)
      date = Date.new(2019, 06, args.fetch('confday'))
      # talks = repo.by_date(date)

      send_message(
          chat_id: callback.message.chat.id,
          text: talks_message(date),
          parse_mode: :markdown
      )
      send_message(
          chat_id: callback.message.chat.id,
          text: 'time:',
          reply_markup: inline_keyboard(
              [
                  button('18:00', 'schedule', confday: 1),
                  button('19:00', 'schedule', confday: 2)
              ]
          )
      )
    end

    def talks_message(confday)
      <<~MARKDOWN
        *——— #{confday.strftime('%B %d, %a')} ———*
      MARKDOWN
    end
  end
end
