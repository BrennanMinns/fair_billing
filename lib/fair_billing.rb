require 'fair_billing/log_entry'
require 'fair_billing/log_parser'
require 'fair_billing/user_sessions'

module FairBilling
  def self.run(file_path)
  rescue StandardError => e
    warn "Error: #{e.message}"
    exit 1
  end
end
