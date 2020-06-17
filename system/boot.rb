# frozen_string_literal: true

ENV['APP_NAME'] = 'icalendar'

if %w[development test].include? ENV['APP_ENV']
  require 'bundler'
  Bundler.setup
  require 'pry'
  require 'dotenv'
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
  def self.init
    Zeitwerk::Loader.new.tap do |loader|
      loader.enable_reloading
      loader.preload File.join('lib/services/application_service.rb')
      loader.preload File.join('lib')
      loader.push_dir File.join('app')
      loader.collapse('lib/services')
      loader.collapse('lib/models')
      loader.preload File.join('config/initializers')
      loader.setup
    end
  end
end

ICalendarBot.init
