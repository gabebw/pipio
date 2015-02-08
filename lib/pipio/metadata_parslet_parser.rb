require "parslet"
require "parslet/convenience"

module Pipio
  class MetadataParsletParser
    def initialize(first_line)
      @first_line = first_line || ''
    end

    def parse
      parser = InnerParser.new
      result = parser.parse_with_debug(@first_line)
      {
        my_screen_name: result[:my_screen_name],
        their_screen_name: result[:their_screen_name],
        start_time: (parse_time(result[:start_time]) rescue ""),
        service: result[:service]
      }
    end

    private

    def start_time
      match = @first_line.match(%r{ at ([-A-Za-z0-9/: ]+) on })
      if match
        timestamp = match[1]
        parse_time(timestamp)
      end
    end

    def parse_time(timestamp)
      begin
        Time.parse(timestamp)
      rescue ArgumentError
        TimeParser.new(nil, nil, nil).parse(timestamp)
      end
    end
  end

  class InnerParser < Parslet::Parser
    rule(:screen_name) do
      match('[^()]').repeat(1)
    end
    rule(:start_time) { match('[-A-Za-np-z0-9/: ]').repeat(1) }
    rule(:service) { match('[a-z]').repeat(1) }
    rule(:prefix) do
      str('<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">')
    end

    rule :line do
      prefix.as(:prefix) >>
        str("<title>") >>
        str("Conversation with ") >>
        screen_name.as(:their_screen_name) >>
        str(" at ") >>
        start_time.as(:start_time) >>
        str("on ") >>
        screen_name.as(:my_screen_name) >>
        str(" (") >>
        service.as(:service) >>
        str(")") >>
        any.repeat
    end

    root :line
  end
end
