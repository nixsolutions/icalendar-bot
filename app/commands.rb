# frozen_string_literal: true

module Commands
  Error = Class.new(StandardError)
  FallbackError = Class.new(Error)

  COMMAND_CLASSES = {
    '/start': Commands::Start,
    '📆 Schedule': Commands::CreateAppointment::SelectDay
  }.freeze

  CALLBACK_CLASSES = {
    'select_time': Commands::CreateAppointment::SelectTime
  }.freeze

  FALLBACK_COMMAND_CLASS = Commands::Unknown

  def self.class_for(command_name)
    COMMAND_CLASSES.fetch(command_name, FALLBACK_COMMAND_CLASS)
  end

  def self.class_for_callback(callback_name)
    CALLBACK_CLASSES.fetch(callback_name, FALLBACK_COMMAND_CLASS)
  end
end
