require 'rubygems'
require 'bundler'

Bundler.require

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/alarmcron.db")

configure do
  config_file 'settings.yml'
end

get '/' do
  "#{settings.crontab} #{settings.start_command} #{settings.stop_command}"
end
