# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'i18n', require: false
gem 'rake'

# storage
gem 'dynamoid'

# debug
gem 'pry'

# boot
gem 'zeitwerk'

# service api
gem 'icalendar'
gem 'telegram-bot-ruby', '~> 0.9.0', require: 'telegram/bot'

# fast JSON processing
gem 'oj'
# gem 'multi_json'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
end

group :test do
  gem 'rspec'
end
