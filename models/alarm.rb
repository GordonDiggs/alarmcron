class Alarm
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  property :starts_at, DateTime, required: true
  property :ends_at, DateTime, required: true
  property :day, Integer, required: true, unique: true

  validates_with_method :validate_date_range

  after :save, :update_crontab

  [:starts_at, :ends_at].each do |meth|
    define_method "#{meth}_time" do
      self.send(meth).strftime("%-l:%M %P")
    end
  end

  private
  def update_crontab
    AlarmCrontab.new.update
  end

  def validate_date_range
    if ends_at > starts_at
      true
    else
      [false, "End time must be after start time"]
    end
  end
end
