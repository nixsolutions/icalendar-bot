# frozen_string_literal: true

describe Commands::Unknown do
  subject(:command_unknown) { described_class.new(bot) }

  let(:bot) { double('bot', send_message: nil) }
  let(:user) { Telegram::Bot::Types::User.new(id: 1, first_name: 'Test', last_name: 'Test') }

  describe 'on message' do
    let(:chat)     { Telegram::Bot::Types::Chat.new(id: 1) }
    let(:message)  { Telegram::Bot::Types::Message.new(chat: chat) }

    it 'responds with unknown message' do
      expect(bot).to receive(:send_message).with(
        chat_id: 1,
        text: I18n.t('unknown.text')
      )
      command_unknown.call(message, User.new)
    end
  end

  describe 'on callback' do
    let(:message_data) { { command: 'select_time' }.to_json }
    let(:callback) { Telegram::Bot::Types::CallbackQuery.new(id: 2, data: message_data, from: user) }

    it 'responds with unknown callback query' do
      expect(bot).to receive(:answer_callback_query).with(
        callback_query_id: '2',
        text: I18n.t('unknown.callback_text')
      )
      command_unknown.call(callback, User.new)
    end
  end
end
