module Pipio
  # A holding object for each line of the chat. It is subclassed as
  # appropriate (eg AutoReplyMessage). Each subclass (but not Message
  # itself) has its own to_s which prints out its information in a format
  # appropriate for putting in an Adium log file.
  class Message
    include Comparable

    def initialize(sender_screen_name, time, sender_alias)
      @sender_screen_name = sender_screen_name
      @time = time
      @sender_alias = sender_alias
    end

    attr_reader :sender_screen_name, :time, :sender_alias

    private

    def adium_formatted_time
      @time.xmlschema.sub(/:00$/, "00")
    end
  end
end
