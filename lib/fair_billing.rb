# frozen_string_literal: true

require 'fair_billing/log_entry'
require 'fair_billing/log_parser'
require 'fair_billing/user_sessions'

module FairBilling
  def self.run(file_path)
    parser = LogParser.new(file_path)
    entries, min_time, max_time = parser.parse

    calculator = UserSessions.new(entries, min_time, max_time)
    results = calculator.compute_results

    results.sort_by { |user, _| user }.each do |user, (sessions, duration)|
      puts "#{user} #{sessions} #{duration}"
    end
  rescue StandardError => e
    warn "Error: #{e.message}"
    exit 1
  end
end
