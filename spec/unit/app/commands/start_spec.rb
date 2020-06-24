# frozen_string_literal: true

describe Commands::Start do
  subject { described_class.new(bot) }

  let(:bot)      { double('bot', send_message: nil) }
  let(:user)     { User.new(id: 1, first_name: 'Test', last_name: 'Test') }
  let(:chat)     { Telegram::Bot::Types::Chat.new(id: 1) }
  let(:message)  { Telegram::Bot::Types::Message.new(chat: chat) }
  let(:keyboard) { instance_double('Telegram::Bot::Types::InlineKeyboardMarkup') }

  before do
    allow_any_instance_of(Commands::Keyboards::MainReplyKeyboard).to receive(:call) { keyboard }
  end

  describe '#call' do
    it 'sends welcome message with keyboard' do
      expect(bot).to receive(:send_message).with(
        chat_id: chat.id,
        text: I18n.t('welcome.text'),
        parse_mode: :markdown,
        reply_markup: keyboard
      )
      expect(user).to receive(:update_state).with(User::States::START)
      subject.call(message, user)
    end
  end
end
