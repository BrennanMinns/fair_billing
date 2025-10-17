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
      end
    end
  end
end