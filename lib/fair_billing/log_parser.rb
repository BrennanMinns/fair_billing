module FairBilling
  class LogParser
    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      lines = File.readlines(@file_path).map(&:strip)
    end
  end
end