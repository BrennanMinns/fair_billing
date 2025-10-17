# frozen_string_literal: true

module FairBilling
  class UserSessions
    def initialize(entries, min_time, max_time)
      @entries = entries
      @min_time = min_time
      @max_time = max_time
    end

    def compute_results
      return {} if @entries.empty?

      @entries.group_by(&:user).transform_values do |user_entries|
        starts = []
        durations = []

        user_entries.each do |entry|
          if entry.action == 'Start'
            starts << entry.time_seconds
          else
            start_time = starts.pop || @min_time
            durations << (entry.time_seconds - start_time)
          end
        end

        durations += starts.map { |s| @max_time - s }

        [durations.size, durations.sum]
      end
    end
  end
end
