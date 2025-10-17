# frozen_string_literal: true

require 'fair_billing'

describe FairBilling::LogEntry do
  describe '#initialize' do
    it 'parses valid line' do
      log = FairBilling::LogEntry.new('14:02:03 ALICE99 Start')
      expect(log.time_seconds).to eq(14 * 3600 + 2 * 60 + 3)
      expect(log.user).to eq('ALICE99')
      expect(log.action).to eq('Start')
      expect(log.valid?).to be true
    end

    it 'ignores invalid line' do
      log = FairBilling::LogEntry.new('invalid')
      expect(log.valid?).to be false
    end

    it 'ignores invalid time' do
      log = FairBilling::LogEntry.new('25:00:00 USER Start')
      expect(log.valid?).to be false
    end

    it 'ignores invalid user' do
      log = FairBilling::LogEntry.new('25:00:00 1 Start')
      expect(log.valid?).to be false
    end

    it 'ignores invalid start/end' do
      log = FairBilling::LogEntry.new('25:00:00 1 invalid')
      expect(log.valid?).to be false
    end
  end
end
