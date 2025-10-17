#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require_relative "../lib/fair_billing"

if ARGV.length != 1
  warn "Usage: bin/fair_billing <log_file_path>"
  exit 1
end

FairBilling.run(ARGV[0])