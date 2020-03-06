# frozen_string_literal: true

describe Commands::Unknown do
  subject(:command_unknown) { described_class.new(bot) }

  let(:bot) { double('bot', send_message: nil) }
  let(:chat)     { Telegram::Bot::Types::Chat.new(id: 1) }
  let(:message)  { Telegram::Bot::Types::Message.new(chat: chat) }

  describe 'on message' do
    it 'responds with unknown message' do
      expect(bot).to receive(:send_message).with(
        chat_id: 1,
        text: I18n.t('unknown.text')
      )
      command_unknown.call(message)
    end
  end
end
