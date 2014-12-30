require "active_support"
require "active_support/time"

module Pipio
  class TimeParser
    NO_DATE = /\A\d{1,2}:\d{1,2}:\d{1,2}(?: [AP]M)?\Z/

    # 01/22/2008 03:01:45 PM
    UNPARSEABLE_BY_DATETIME_PARSE = '%m/%d/%Y %I:%M:%S %P'

    def initialize(year, month, day)
      @fallback_date_string = "#{year}-#{month}-#{day}"
    end

    def parse(timestamp)
      if timestamp
        if has_no_date?(timestamp)
          parse_with_date(@fallback_date_string + " " + timestamp).utc
        else
          parse_with_date(timestamp).utc
        end
      end
    end

    private

    def parse_with_date(timestamp)
      begin
        current_timezone.parse(timestamp)
      rescue ArgumentError
        current_timezone.parse Time.strptime(timestamp, UNPARSEABLE_BY_DATETIME_PARSE).to_s
      end
    end

    def has_no_date?(timestamp)
      timestamp.strip =~ NO_DATE
    end

    def current_timezone
      ActiveSupport::TimeZone[current_timezone_identifier]
    end

    def current_timezone_identifier
      Time.now.zone
    end
  end
end
