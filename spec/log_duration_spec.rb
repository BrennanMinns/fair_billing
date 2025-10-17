# frozen_string_literal: true

require 'fair_billing'

describe FairBilling::LogDuration do
  subject(:results) { described_class.new(logs, min_time, max_time).compute_results }

  let(:logs) do
    [FairBilling::LogEntry.new('14:02:03 ALICE99 Start'),
     FairBilling::LogEntry.new('14:02:10 NICK13 Start'),
     FairBilling::LogEntry.new('14:02:34 ALICE99 End'),
     FairBilling::LogEntry.new('14:02:50 JAMES34 End')]
  end

  let(:min_time) { 14 * 3600 + 2 * 60 + 3 }
  let(:max_time) { 14 * 3600 + 2 * 60 + 50 }

  describe '#compute_results' do
    it 'calculates paired logs' do
      expect(results['ALICE99']).to eq([1, 31])
    end

    it 'calculates unpaired end log' do
      expect(results['JAMES34']).to eq([1, 47])
    end

    it 'calculates unpaired start log' do
      expect(results['NICK13']).to eq([1, 40])
    end
  end
end
