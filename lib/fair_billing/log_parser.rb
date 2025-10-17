# frozen_string_literal: true

module FairBilling
  class LogParser
    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      lines = File.readlines(@file_path).map(&:strip)
      entries = lines.map { |line| LogEntry.new(line) }.select(&:valid?)
      if entries.empty?
        [[], nil, nil]
      else
        min_time = entries.map(&:time_seconds).min
        max_time = entries.map(&:time_seconds).max
        [entries, min_time, max_time]
      end
    end
  end
end
