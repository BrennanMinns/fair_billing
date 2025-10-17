# frozen_string_literal: true

module FairBilling
  class LogDuration
    def initialize(logs, min_time, max_time)
      @logs = logs
      @min_time = min_time
      @max_time = max_time
    end

    def compute_results
      return {} if @logs.empty?

      @logs.group_by(&:user).transform_values do |logs|
        unpaired_starts = []
        log_durations = []

        logs.each do |log|
          if log.action == 'Start'
            unpaired_starts << log.time_seconds
          else
            paired_start_time = unpaired_starts.pop || @min_time
            log_durations << (log.time_seconds - paired_start_time)
          end
        end

        log_durations += unpaired_starts.map { |s| @max_time - s }

        [log_durations.size, log_durations.sum]
      end
    end
  end
end
