module Pipio
  class MetadataParser
    def initialize(first_line)
      @first_line = first_line || ''
    end

    def parse
      {
        my_screen_name: my_screen_name,
        their_screen_name: their_screen_name,
        start_time: start_time,
        service: service
      }
    end

    private

    def service
      match = @first_line.match(/\(([a-z]+)\)/)
      if match
        match[1]
      end
    end

    def their_screen_name
      match = @first_line.match(/Conversation with (.+?) at/)
      if match
        match[1]
      end
    end

    def my_screen_name
      match = @first_line.match(/ on ([^()]+) /)
      if match
        match[1]
      end
    end

    def start_time
      match = @first_line.match(%r{ at ([-A-Za-z0-9/: ]+) on })
      if match
        timestamp = match[1]
        parse_time(timestamp)
      end
    end

    def parse_time(timestamp)
      begin
        Time.strptime(timestamp, '%m/%d/%Y %I:%M:%S %p')
      rescue ArgumentError
        TimeParser.new(nil, nil, nil).parse(timestamp)
      end
    end
  end
end
