class AlarmCrontab
  def initialize
    @alarms = Alarm.all
  end

  def cron_entries
    @alarms.map do |alarm|
      [
        "#{alarm.starts_at.minute} #{alarm.starts_at.hour} * * #{alarm.day} #{ENV['start_command']}",
        "#{alarm.ends_at.minute} #{alarm.ends_at.hour} * * #{alarm.day} #{ENV['stop_command']}"
      ].join("\n")
    end.join("\n")
  end

  def update
    File.open(ENV['crontab'], 'w') do |file|
      file.write cron_entries
    end
  end
end

