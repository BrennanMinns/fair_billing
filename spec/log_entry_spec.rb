# frozen_string_literal: true
require "fair_billing"

RSpec.describe FairBilling::LogEntry do
  subject(:entry) { described_class.new(line) }

  context "with a valid line" do
    let(:line) { "14:02:03 ALICE99 Start" }

    it "parses fields and is valid", :aggregate_failures do
      expect(entry.time_seconds).to eq(14 * 3600 + 2 * 60 + 3)
      expect(entry.user).to eq("ALICE99")
      expect(entry.action).to eq("Start")
      expect(entry.valid?).to be(true)
    end
  end

  context "when the log is invalid" do
    shared_examples "invalid" do
      it { is_expected.not_to be_valid }
    end

    context "totally malformed" do
      let(:line) { "invalid" }
      it_behaves_like "invalid"
    end

    context "invalid time" do
      let(:line) { "25:00:00 JAMIE Start" }
      it_behaves_like "invalid"
    end

    context "invalid user" do
      let(:line) { "14:00:00 ALICE-99 Start" }
      it_behaves_like "invalid"
    end

    context "invalid action" do
      let(:line) { "14:00:00 JAMIE Nope" }
      it_behaves_like "invalid"
    end
  end
end
