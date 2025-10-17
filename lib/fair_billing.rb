# frozen_string_literal: true

require 'fair_billing/log_entry'
require 'fair_billing/log_parser'
require 'fair_billing/log_duration'

module FairBilling
  def self.run(file_path)
    parser = LogParser.new(file_path)
    logs, min_time, max_time = parser.parse

    calculator = LogDuration.new(logs, min_time, max_time)
    results = calculator.compute_results

    results.sort_by { |user, _| user }.each do |user, (logs, duration)|
      puts "#{user} #{logs} #{duration}"
    end
  rescue StandardError => e
    warn "Error: #{e.message}"
    exit 1
  end
end
