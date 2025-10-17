module FairBilling
  class LogEntry
    attr_reader :time_seconds, :user, :action

    LINE_REGEX = /^(\d{2}:\d{2}:\d{2}) (\w+) (Start|End)$/

    def initialize(line)
      matches = line.match(LINE_REGEX)
      return unless matches

      time_str = matches[1]
      @user = matches[2]
      @action = matches[3]

      hours, minutes, seconds = time_str.split(':').map(&:to_i)
      return unless hours.between?(0, 23) && minutes.between?(0, 59) && seconds.between?(0, 59)

      @time_seconds = hours * 3600 + minutes * 60 + seconds
    end

    def valid?
      !@time_seconds.nil?
    end
  end
end