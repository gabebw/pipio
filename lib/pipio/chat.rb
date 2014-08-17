module Pipio
  # The container object for each Message in a chat. It includes the Enumerable
  # module, so each/map/reject etc all work and will iterate over the Messages.
  class Chat
    include Enumerable

    def initialize(messages, metadata)
      @messages = messages
      @metadata = metadata
    end

    attr_reader :messages

    def start_time
      @metadata.start_time
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
      map(&:to_s).join("\n")
    end

    # Iterate over each Message.
    def each(&block)
      @messages.each(&block)
    end
  end
end
