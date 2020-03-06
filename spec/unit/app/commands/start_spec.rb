# frozen_string_literal: true

describe Commands::Start do
  subject(:command_start) { described_class.new(bot) }

  let(:bot)      { double('bot', send_message: nil) }
  let(:chat)     { Telegram::Bot::Types::Chat.new(id: 1) }
  let(:message)  { Telegram::Bot::Types::Message.new(chat: chat) }
  let(:keyboard) { instance_double('Telegram::Bot::Types::InlineKeyboardMarkup') }

  it 'sends welcome message with keyboard' do
    allow_any_instance_of(Commands::Keyboards::MainReplyKeyboard).to receive(:call) { keyboard }
    expect(bot).to receive(:send_message).with(
      chat_id: 1,
      text: I18n.t('welcome.text'),
      parse_mode: :markdown,
      reply_markup: keyboard
    )
    command_start.call(message)
  end
end
