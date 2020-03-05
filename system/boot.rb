# frozen_string_literal: true

require 'bundler'

Bundler.require
require_relative 'application'
root = Application.root

env_path = "#{root}/.env"
env_path + ".#{ENV.fetch('APP_ENV')}" if ENV.fetch('APP_ENV')
Dotenv.overload env_path

Import = Application.injector
ArgsImport = Import.args

Dir.glob(root.join('system/boot/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/commands/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/commands/keyboards/*.rb')).sort.each { |f| require f }

Application.finalize!