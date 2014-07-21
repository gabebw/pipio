module Pipio
  # The container object for each line of a parsed chat. It includes the
  # Enumerable module, so each/map/reject etc all work.
  class Chat
    include Enumerable

    def initialize(lines, metadata)
      @lines = lines
      @metadata = metadata
    end

    attr_reader :lines

    def start_time_xmlschema
      @metadata.start_time.xmlschema
    end

    def my_screen_name
      @metadata.my_screen_name
    end

    def their_screen_name
      @metadata.their_screen_name
    end

    def service
      @metadata.service
    end

    def to_s
      map(&:to_s).join
    end

    # Iterate over each Message.
    def each(&block)
      @lines.each(&block)
    end
  end
end
