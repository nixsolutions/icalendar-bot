# frozen_string_literal: true

describe Bot::Dispatcher do
  subject { described_class.new(bot, message) }

  let(:bot)     { Telegram::Bot::Api.new('token') }
  let(:user)    { Telegram::Bot::Types::User.new(id: 1, first_name: 'Test', last_name: 'Test') }
  let(:unknown_command_class) { Commands::Unknown }

  before do
    allow(command_class).to receive(:new) { command } if defined?(command_class)
    allow(User).to receive(:find_or_create) { user }
  end

  describe 'on message' do
    let(:message) { Telegram::Bot::Types::Message.new(text: command_name, from: user) }

    context 'if command is recognized' do
      let(:command_name) { '/start' }
      let(:command_class) { Commands::Start }
      let(:command) { instance_double(command_class) }

      it 'call correct command' do
        allow(Bot::StepHandler).to receive(:call).with(message, user) { command_class }
        allow(command_class).to receive(:new) { command }
        expect(command).to receive(:call).with(message, user)
        subject.call
      end
    end

    context 'if command not recognized' do
      let(:command_name) { 'some_test_command' }
      let(:fallback_command) { instance_double(unknown_command_class) }

      it 'call fallback_command' do
        allow(Bot::StepHandler).to receive(:call).with(message, user) { unknown_command_class }
        allow(unknown_command_class).to receive(:new) { fallback_command }
        expect(fallback_command).to receive(:call).with(message, user)
        subject.call
      end
    end

    context 'if message not valid' do
      let(:message) { OpenStruct.new(text: 'test', from: user) }
      let(:fallback_command) { instance_double(unknown_command_class) }

      it 'call some command' do
        allow(unknown_command_class).to receive(:new) { fallback_command }
        expect(Bot::StepHandler).not_to receive(:call)
        expect(fallback_command).to receive(:call).with(message, user)
        subject.call
      end
    end
  end

  describe 'on callback' do
    let(:message_data) {  { command: 'select_time' }.to_json }
    let(:message) { Telegram::Bot::Types::CallbackQuery.new(data: message_data, from: user) }

    context 'if command is recognized' do
      let(:command_callback) { Commands::CreateAppointment::SelectTime }
      let(:command) { instance_double(command_callback) }

      it 'call correct command' do
        allow(command_callback).to receive(:new) { command }
        expect(command).to receive(:call).with(message, user)
        subject.call
      end
    end
  end
end
