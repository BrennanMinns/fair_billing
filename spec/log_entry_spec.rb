# frozen_string_literal: true

require 'fair_billing'

describe FairBilling::LogEntry do
  describe '#initialize' do
    it 'parses valid line' do
      entry = FairBilling::LogEntry.new('14:02:03 ALICE99 Start')
      expect(entry.time_seconds).to eq(14 * 3600 + 2 * 60 + 3)
      expect(entry.user).to eq('ALICE99')
      expect(entry.action).to eq('Start')
      expect(entry.valid?).to be true
    end

    it 'ignores invalid line' do
      entry = FairBilling::LogEntry.new('invalid')
      expect(entry.valid?).to be false
    end

    it 'ignores invalid time' do
      entry = FairBilling::LogEntry.new('25:00:00 USER Start')
      expect(entry.valid?).to be false
    end

    it 'ignores invalid user' do
      entry = FairBilling::LogEntry.new('25:00:00 1 Start')
      expect(entry.valid?).to be false
    end

    it 'ignores invalid start/end' do
      entry = FairBilling::LogEntry.new('25:00:00 1 invalid')
      expect(entry.valid?).to be false
    end
  end
end
