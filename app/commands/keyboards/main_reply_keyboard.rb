# frozen_string_literal: true

module Commands
  module Keyboards
    class MainReplyKeyboard
      include KeyboardHelpers

      def call
        reply_keyboard(
          [button(I18n.t('welcome.schedule_command')), button(I18n.t('welcome.my_events'))]
        )
      end
    end
  end
end
