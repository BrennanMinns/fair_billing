require 'fair_billing'

describe FairBilling::LogParser do
  let(:file_path) { 'examples/sample_file.txt' }
  let(:empty_file_path) { 'examples/empty_file.txt' }

  describe '#parse' do
    it 'parses valid entries' do
      parser = FairBilling::LogParser.new(file_path)
      entries, min_time, max_time = parser.parse
      expect(entries.size).to eq(11)
      expect(min_time).to eq(14 * 3600 + 2 * 60 + 3)
      expect(max_time).to eq(14 * 3600 + 4 * 60 + 41)
    end

    it 'returns empty for no valid entries' do
      parser = FairBilling::LogParser.new(empty_file_path)
      entries, min_time, max_time = parser.parse
      expect(entries).to eq([])
      expect(min_time).to be_nil
      expect(max_time).to be_nil
    end
  end
end