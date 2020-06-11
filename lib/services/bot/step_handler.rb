# frozen_string_literal: true

module Bot
  class StepHandler < ApplicationService
    attr_reader :message, :user

    def initialize(message, user)
      @message = message
      @user = user
    end

    def call
      return Commands.class_for(command_name) if Commands.class_for(command_name) != Commands::Unknown

      Commands.class_for(bot_status)&.available_transition || Commands::Unknown
    end

    private

    def command_name
      message.text&.gsub(/_\d+$/, '')&.to_sym
    end

    def bot_status
      user.bot_status.to_sym
    end
  end
end
