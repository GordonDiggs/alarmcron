require 'bundler'
Bundler.require

class Alarmcron < Sinatra::Base
  configure :development do
    require "better_errors"
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  configure do
    Dir["./presenters/*.rb"].each {|file| require file }

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
    puts params.inspect
    @presenter = AlarmPresenter.new
    haml :index
  end
end
