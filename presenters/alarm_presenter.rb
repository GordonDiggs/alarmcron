class AlarmPresenter
  DAYS = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday].freeze

  def day_string
    DAYS[index]
  end
end
