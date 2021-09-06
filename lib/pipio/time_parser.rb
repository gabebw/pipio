require "active_support"
require "active_support/time"

module Pipio
  class TimeParser
    NO_DATE = /\A\d{1,2}:\d{1,2}:\d{1,2}(?: [AP]M)?\Z/

    # 01/22/2008 03:01:45 PM
    UNPARSEABLE_BY_DATETIME_PARSE = '%m/%d/%Y %I:%M:%S %P'

    def initialize(year, month, day)
      @fallback_date_string = "#{year}-#{month}-#{day}"
      @last_timestamp = 0
    end

    def parse(timestamp)
      if timestamp
        if has_no_date?(timestamp)
          test_timestamp = parse_with_date(@fallback_date_string + " " + timestamp).utc

          if (@last_timestamp > test_timestamp.to_i)
            @fallback_date_string = (Date.parse(@fallback_date_string) + 1.day).to_s
          end
          @last_timestamp = parse_with_date(@fallback_date_string + " " + timestamp).utc.to_i
          parse_with_date(@fallback_date_string + " " + timestamp).utc
        else
          @last_timestamp = parse_with_date(timestamp).utc.to_i
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
      ActiveSupport::TimeZone[nil] # Replace nil with your actual time zone, e.g. 'America/Toronto'
    end

    def current_timezone_identifier
      Time.now.zone
    end
  end
end
