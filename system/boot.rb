# frozen_string_literal: true

require 'bundler'

Bundler.require
Dotenv.load

require_relative 'application'
root = Application.root

Import = Application.injector
ArgsImport = Import.args

Dir.glob(root.join('system/boot/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/commands/*.rb')).sort.each { |f| require f }
Dir.glob(root.join('app/commands/keyboards/*.rb')).sort.each { |f| require f }

Application.finalize!
