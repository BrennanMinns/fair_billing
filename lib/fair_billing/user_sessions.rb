module FairBilling
  class UserSessions
    def initialize(entries, min_time, max_time)
      @entries = entries
      @min_time = min_time
      @max_time = max_time
    end

    def compute_results
    end
  end
end