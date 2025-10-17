# frozen_string_literal: true

require 'fair_billing'

describe FairBilling::UserSessions do
  let(:entries) do
    [FairBilling::LogEntry.new('14:02:03 ALICE99 Start'),
     FairBilling::LogEntry.new('14:02:34 ALICE99 End')]
  end

  let(:min_time) { 14 * 3600 + 2 * 60 + 3 }
  let(:max_time) { 14 * 3600 + 2 * 60 + 34 }

  describe '#compute_results' do
    it 'calculates paired session' do
      calculator = FairBilling::UserSessions.new(entries, min_time, max_time)
      results = calculator.compute_results
      expect(results['ALICE99']).to eq([1, 31])
    end

    it 'calculates unpaired end' do
      entries = [FairBilling::LogEntry.new('14:02:34 ALICE99 End')]
      calculator = FairBilling::UserSessions.new(entries, min_time, max_time)
      results = calculator.compute_results
      expect(results['ALICE99']).to eq([1, 31])
    end

    it 'calculates unpaired start' do
      entries = [FairBilling::LogEntry.new('14:02:03 ALICE99 Start')]
      calculator = FairBilling::UserSessions.new(entries, min_time, max_time)
      results = calculator.compute_results
      expect(results['ALICE99']).to eq([1, 31])
    end
  end
end
