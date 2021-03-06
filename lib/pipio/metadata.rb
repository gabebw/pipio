module Pipio
  class Metadata
    def initialize(metadata_hash)
      @service = metadata_hash[:service]
      @my_screen_name = normalize_screen_name(metadata_hash[:my_screen_name])
      @their_screen_name = metadata_hash[:their_screen_name]
      @start_time = metadata_hash[:start_time]
    end

    attr_reader :my_screen_name, :their_screen_name, :start_time, :service

    def valid?
      [@their_screen_name, @my_screen_name, @start_time, @service].all?
    end

    def start_year
      @start_time.year
    end

    def start_month
      @start_time.mon
    end

    def start_mday
      @start_time.mday
    end

    private

    def normalize_screen_name(screen_name)
      screen_name && screen_name.downcase.gsub(' ', '')
    end
  end
end
