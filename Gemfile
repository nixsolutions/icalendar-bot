# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.8'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'i18n', require: false
gem 'rake'

# storage
gem 'dynamoid'
# gem 'rom'
# gem 'rom-yaml'
# gem 'rom-redis', :github => 'rom-rb/rom-redis'

# debug
gem 'pry'
gem 'pry-byebug'

# boot
gem 'dotenv'
gem 'dry-system'

# service api
gem 'telegram-bot-ruby', '~> 0.9.0', require: 'telegram/bot'

# fast JSON processing
gem 'oj'
# gem 'multi_json'

group :development, :test do
  gem 'rubocop', require: false
  gem 'rubocop-performance'
end

group :test do
  gem 'rspec'
end
