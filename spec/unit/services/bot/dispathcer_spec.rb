# frozen_string_literal: true

describe Dispatcher do
  subject(:dispatcher) { described_class.new(bot) }

  let(:bot)     { Telegram::Bot::Api.new('token') }
  let(:message) { Telegram::Bot::Types::Message.new(text: command_name) }

  let(:command) { instance_double(command_class) }
  let(:fallback_command) { instance_double(Commands::Unknown) }

  before do
    allow(command_class).to receive(:new) { command } if defined?(command_class)
    allow(Commands::Unknown).to receive(:new) { fallback_command }
  end

  describe 'on message' do
    context 'if command is recognized' do
      let(:command_class) { Commands::Start }
      let(:command_name)  { '/start' }

      it 'call correct command' do
        expect(command).to receive(:call).with(message)
        dispatcher.call(message)
      end
    end

    context 'if command not recognized' do
      let(:command_name) { 'some_test_command' }

      it 'call fallback_command' do
        expect(fallback_command).to receive(:call).with(message)
        dispatcher.call(message)
      end
    end
  end
end
