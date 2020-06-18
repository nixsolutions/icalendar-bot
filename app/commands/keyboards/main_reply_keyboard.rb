# frozen_string_literal: true

module Commands
  module Keyboards
    class MainReplyKeyboard
      include KeyboardHelpers

      def call
        reply_keyboard(
          [button(schedule_command)], [button(events_command)]
        )
      end

      private

      def schedule_command
        "📝 I18n.t('welcome.schedule_command')"
      end

      def events_command
        "🗓 I18n.t('welcome.my_events')"
      end
    end
  end
end
