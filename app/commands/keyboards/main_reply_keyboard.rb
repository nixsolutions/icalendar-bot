# frozen_string_literal: true

module Commands
  module Keyboards
    class MainReplyKeyboard
      include KeyboardHelpers

      def call
        reply_keyboard(
          [button('💎'), button('')]
        )
      end
    end
  end
end
