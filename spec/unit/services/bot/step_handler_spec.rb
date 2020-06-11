# frozen_string_literal: true

describe Bot::StepHandler do
  subject { described_class.new(message, user) }

  let(:user) { Telegram::Bot::Types::User.new(id: 1, first_name: 'Test', last_name: 'Test') }
  let(:unknown_command_class) { Commands::Unknown }

  context 'on valid command' do
    let(:command_name) { '/start' }
    let(:expected_command_class) { Commands::Start }
    let(:message) { Telegram::Bot::Types::Message.new(text: command_name, from: user) }

    context 'command name has the appropriate command class' do
      it { expect(subject.call).to eq(expected_command_class) }
    end
  end
  #
  # context 'on invalid command' do
  #   let(:command_name) { 'test_command' }
  #   let(:bot_status) { 'test_bot_status' }
  #   let(:message) { Telegram::Bot::Types::Message.new(text: command_name, from: user) }
  #
  #   context 'when bot status of the user does not have a transition to another class' do
  #     let(:class_without_transition) { double('class', available_transition: nil) }
  #
  #     it do
  #       allow(user).to receive(:bot_status) { bot_status }
  #       allow(Commands).to receive(:class_for).with(command_name) { nil }
  #       allow(Commands).to receive(:class_for).with(bot_status) { class_without_transition }
  #       expect(subject.call).to eq(unknown_command_class)
  #     end
  #   end
  #
  #   context 'when bot status of the user have a transition to another class' do
  #     let(:bot_status) { 'some_status' }
  #     let(:expected_command_class) { Class.new }
  #     let(:class_with_transition) { double(Commands::Start, available_transition: expected_command_class) }
  #
  #     it do
  #       # allow(user).to receive(:bot_status) { 'some_status' }
  #       allow(Commands).to receive(:class_for) { class_with_transition }
  #       expect(subject.call).to eq(expected_command_class)
  #     end
  #   end
  # end
end
