module FairBilling
  def self.run(file_path)

  rescue StandardError => e
    warn "Error: #{e.message}"
    exit 1
  end
end
