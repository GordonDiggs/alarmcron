require 'rubygems'
require 'bundler'

Bundler.require


configure do
  config_file 'settings.yml'

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/alarmcron.db")
  require_relative "models/alarm"
  DataMapper.finalize
  Alarm.auto_upgrade!
end

get '/' do
  Alarm.create(starts_at: Time.now, ends_at: Time.now, day: '1')
  @alarms = Alarm.all
  "#{settings.crontab} #{settings.start_command} #{settings.stop_command} #{@alarms.inspect}"
end
