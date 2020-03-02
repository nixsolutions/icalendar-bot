# frozen_string_literal: true

require_relative 'commands/keyboard_helpers'
# require_relative 'commands/context_helpers'
require_relative 'commands/base'
Dir['./app/commands/**/*.rb'].each { |f| require f.delete_prefix('app/') }

module Commands
  Error = Class.new(StandardError)
  FallbackError = Class.new(Error)

  COMMAND_CLASSES = {
    '/start' => Commands::Start
    # 'create_appointment': Commands::CreateAppointment.new(bot),
  }.freeze

  CALLBACK_CLASSES = {
  }.freeze

  FALLBACK_COMMAND_CLASS = Commands::Unknown

  def self.class_for(command_name)
    COMMAND_CLASSES.fetch(command_name, FALLBACK_COMMAND_CLASS)
  end

  def self.class_for_callback(callback_name)
    CALLBACK_CLASSES.fetch(callback_name, FALLBACK_COMMAND_CLASS)
  end
end
