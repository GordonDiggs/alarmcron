require 'rubygems'
require 'bundler'

Bundler.require

configure :development do
  require "better_errors"
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

configure do
  {
    'crontab' => 'cron.txt',
    'start_command' => 'echo started',
    'stop_command' => 'echo stopped'
  }.each do |key, value|
    ENV[key] = value
  end

  register Sinatra::Twitter::Bootstrap::Assets

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/alarmcron.db")
  require_relative "models/alarm"
  require_relative 'alarm_crontab'
  DataMapper.finalize
  Alarm.auto_upgrade!
end

get '/' do
  haml :index
end
