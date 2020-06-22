# frozen_string_literal: true

ENV['APP_NAME'] = 'icalendar'

if %w[development test].include? ENV['APP_ENV']
  ENV['AWS_REGION'] = 'test'
  require 'bundler'
  Bundler.setup
  require 'pry'
  require 'dotenv'
  require 'factory_bot'
  Dotenv.overload ".env.#{ENV.fetch('APP_ENV')}"
end

require 'dynamoid'
require 'telegram/bot'
require 'zeitwerk'
require 'i18n'
require 'icalendar'
require 'faraday'
require 'sentry-raven'
require 'multi_json'
require 'oj'

class ICalendarBot
  PRELOAD_FILES = %w[config/initializers lib/services/application_service.rb lib/models/user/states.rb lib].freeze

  def self.init
    Zeitwerk::Loader.new.tap do |loader|
      loader.preload PRELOAD_FILES
      loader.push_dir File.join('app')
      loader.collapse('lib/services')
      loader.collapse('lib/models')
      loader.setup
    end
  end
end

ICalendarBot.init
