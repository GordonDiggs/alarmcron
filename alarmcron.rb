require 'rubygems'
require 'bundler'

Bundler.require

configure do
  {
    'crontab' => 'cron.txt',
    'start_command' => 'echo started',
    'stop_command' => 'echo stopped'
  }.each do |key, value|
    ENV[key] = value
  end

  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/alarmcron.db")
  require_relative "models/alarm"
  require_relative 'alarm_crontab'
  DataMapper.finalize
  Alarm.auto_upgrade!
end

get '/' do
  return AlarmCrontab.new.update

  Alarm.create(starts_at: Time.now, ends_at: Time.now, day: '1')
  @alarms = Alarm.all
  "#{settings.crontab} #{settings.start_command} #{settings.stop_command} #{@alarms.inspect}"
end
