require 'date'
require 'time'

require 'pidgin2adium/version'
require 'pidgin2adium/tag_balancer'
require 'pidgin2adium/parser_factory'
require 'pidgin2adium/parsers/null_parser'
require 'pidgin2adium/parsers/basic_parser'
require 'pidgin2adium/parsers/text_log_parser'
require 'pidgin2adium/parsers/html_log_parser'
require 'pidgin2adium/time_parser'
require 'pidgin2adium/metadata'
require 'pidgin2adium/metadata_parser'

module Pidgin2Adium
  # Parses the provided log.
  # Returns a Chat instance.
  def self.parse(logfile_path, my_aliases)
    logfile_path = File.expand_path(logfile_path)

    factory = ParserFactory.new(my_aliases)
    parser = factory.parser_for(logfile_path)
    parser.parse
  end
end
