class NullAlarm
  include Nobody

  returns_nil_for :id, :starts_at_time, :ends_at_time
end
