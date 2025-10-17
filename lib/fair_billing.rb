require 'fair_billing/log_entry'
require 'fair_billing/log_parser'
require 'fair_billing/user_sessions'

module FairBilling
  def self.run(file_path)
    parser = LogParser.new(file_path)

    calculator = UserSessions.new(entries, min_time, max_time)

  rescue StandardError => e
    warn "Error: #{e.message}"
    exit 1
  end
end
