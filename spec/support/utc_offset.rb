module UtcOffset
  def offset_in_hours_from_utc
    offset_in_seconds = current_timezone.current_period.utc_offset
    offset_in_seconds / 3600
  end

  def current_timezone
    TZInfo::Timezone.get(Time.now.zone)
  end
end

RSpec.configure do |config|
  config.include UtcOffset
end
