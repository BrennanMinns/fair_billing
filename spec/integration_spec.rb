require 'fair_billing'

RSpec.describe "Integration" do
  let(:sample_file) { File.expand_path("../examples/sample_file.txt", __dir__) }
  let(:empty_file)  { File.expand_path("../examples/empty_file.txt", __dir__) }
  let(:missing_file) { File.expand_path("../examples/missing_file.txt", __dir__) }

  it "prints the expected lines for a valid file" do
    expect { FairBilling.run(sample_file) }
      .to output("ALICE99 4 240\nCHARLIE 3 37\n").to_stdout
  end

  it "prints nothing for a file with no valid entries" do
    expect { FairBilling.run(empty_file) }
      .to output("").to_stdout
  end

  it "exits with an error for a missing file" do
    expect {
      expect { FairBilling.run(missing_file) }
        .to output(/Error:/).to_stderr
    }.to raise_error(SystemExit)
  end
end
