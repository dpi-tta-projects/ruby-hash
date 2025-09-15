# spec/phonebook_spec.rb
RSpec.describe "phonebook.rb" do
  describe "output" do
    it "prints one line per entry, any order", points: 3 do
      output = run_script_and_capture_lines("phonebook.rb")

      # Must have exactly three lines like "name: number"
      expect(output.length).to eq(3)
      output.each do |line|
        expect(line).to match(/\A[a-z_]+:\s*\d{3}-\d{4}\z/)
      end
    end
  end

  describe "code" do
    let(:source_code) { strip_comments(File.read("phonebook.rb")) }

    it "iterates with .each and block parameters key, value", points: 2 do
      expect(source_code).to match(/\.\s*each\s+do\s*\|\s*\w+\s*,\s*\w+\s*\|/)
    end

    it "does NOT hard-code complete 'name: number' lines as string literals", points: 2 do
      # Ban any literal like "alice: 555-1111" (any name/number), regardless of printer.
      # This still allows phone numbers to appear as VALUES in the hash literal.
      expect(source_code).not_to match(/^\s*(?:pp|puts|print|p)\s+["'][a-z_]+:\s*\d{3}-\d{4}["']/m),
        "Don't hard-code full lines like \"alice: 555-1111\"; build them from the each block variables"
    end
  end
end
