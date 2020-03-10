# frozen_string_literal: true

module Commands
  module Keyboards
    class MainReplyKeyboard
      include KeyboardHelpers

      def call
        inline_keyboard(
          [button('💎'), button('')]
        )
      end
    end
  end
end
