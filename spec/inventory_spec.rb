# spec/inventory_spec.rb
RSpec.describe "inventory.rb" do
  describe "output" do
    it "uses fetch to print known value", points: 1 do
      output = run_script_and_capture_lines("inventory.rb")

      expect(output[0]).to eq("banana: 5")
    end

    it "uses fetch to print default value", points: 1 do
      output = run_script_and_capture_lines("inventory.rb")

      expect(output[1]).to eq("grape: Not in stock")
    end
  end

  describe "code" do
    let(:source_code) { strip_comments(File.read("inventory.rb")) }

    it "uses Hash#fetch twice (banana & grape with default)", points: 2 do
      expect(source_code).to match(/stock\.fetch\(\s*:banana\s*\)/),
        "Use stock.fetch(:banana)"
      expect(source_code).to match(/stock\.fetch\(\s*:grape\s*,\s*["']Not in stock["']\s*\)/),
        "Use stock.fetch(:grape, \"Not in stock\") for the default"
    end

    it "does not hard-code the final strings", points: 2 do
      # Disallow exact literal strings like "banana: 5" and "grape: Not in stock"
      expect(source_code).not_to match(/["']banana:\s*5["']/),
        "Don't hard-code \"banana: 5\"; derive it from stock.fetch"
      expect(source_code).not_to match(/["']grape:\s*Not in stock["']/),
        "Don't hard-code \"grape: Not in stock\"; derive it from stock.fetch with a default"
    end
  end
end
