class Alarm
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  property :starts_at, DateTime, required: true
  property :ends_at, DateTime, required: true
  property :day, Integer, required: true, unique: true

  after :save, :update_crontab

  private def update_crontab
    # AlarmCrontab.update
  end
end
