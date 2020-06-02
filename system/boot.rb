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

APP_ROOT = '../'
require_relative 'boot/dynamoid'
I18n.load_path << Dir[File.expand_path('config') + '/*.yml']
I18n.default_locale = :en

class ICalendarBot
  attr_reader :loader

  def initialize
    @loader = Zeitwerk::Loader.new
    loader.enable_reloading
    loader.push_dir File.join('app')
    loader.push_dir File.join('lib')
    loader.collapse('lib/services')
    loader.collapse('lib/models')
  end

  def init
    loader.setup
  end
end

bot = ICalendarBot.new
bot.init
