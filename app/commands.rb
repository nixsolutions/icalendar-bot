# frozen_string_literal: true

module Commands
  Error = Class.new(StandardError)
  FallbackError = Class.new(Error)

  COMMAND_CLASSES = {
    '/start': Start,
    '📆 Schedule': CreateAppointment::SelectDay,
    '📆 Создать встречу': CreateAppointment::SelectDay,
    'write_summary': CreateAppointment::WriteSummary,
    'write_description': CreateAppointment::WriteDescription
  }.freeze

  CALLBACK_CLASSES = {
    'select_time': CreateAppointment::SelectTime,
    'select_day': CreateAppointment::SelectDay,
    'confirm_day_time': CreateAppointment::ConfirmDayTime,
    'send_file': CreateAppointment::SendAppointment
  }.freeze

  FALLBACK_COMMAND_CLASS = Unknown

  def self.get_command_name(command_class)
    CALLBACK_CLASSES.key(command_class) || COMMAND_CLASSES.key(command_class)
  end

  def self.class_for(command_name)
    COMMAND_CLASSES.fetch(command_name, FALLBACK_COMMAND_CLASS)
  end

  def self.class_for_callback(callback_name)
    CALLBACK_CLASSES.fetch(callback_name, FALLBACK_COMMAND_CLASS)
  end

  def self.class_or_callback_for(bot_status)
    if class_for_callback(bot_status) == FALLBACK_COMMAND_CLASS
      class_for(bot_status)
    else
      class_for_callback(bot_status)
    end
  end
end
