require 'time'

require 'pipio/version'
require 'pipio/chat'
require 'pipio/tag_balancer'
require 'pipio/time_parser'
require 'pipio/metadata'
require 'pipio/metadata_parser'
require 'pipio/alias_registry'
require 'pipio/file_reader'
require 'pipio/parsers/null_parser'
require 'pipio/parsers/basic_parser'
require 'pipio/parsers/text_log_parser'
require 'pipio/parsers/html_log_parser'
require 'pipio/parser_factory'
require 'pipio/messages/message'
require 'pipio/messages/xml_message'
require 'pipio/messages/auto_reply_message'
require 'pipio/messages/event'
require 'pipio/messages/status_message'
require 'pipio/message_creators/event_message_creator'
require 'pipio/message_creators/status_message_creator'
require 'pipio/message_creators/auto_or_xml_message_creator'
require 'pipio/cleaners/html_cleaner'
require 'pipio/cleaners/text_cleaner'

module Pipio
  # Parses the log at the given path into a Chat.
  def self.parse(logfile_path, my_aliases)
    full_path = File.expand_path(logfile_path)
    factory = ParserFactory.new(full_path, my_aliases)
    factory.parser.parse
  end
end
