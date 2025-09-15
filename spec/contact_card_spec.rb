# spec/contact_card_spec.rb
RSpec.describe "contact_card.rb" do
  describe "output" do
    it "prints 'Name: <name>, Email: <email>, Role: <role>'", points: 2 do
      output = run_script_and_capture_lines("contact_card.rb")

      expect(output[0]).to match(/\AName: .+, Email: .+@.+\..+, Role: .+\z/), "Make sure to match expected output exactly"
    end
  end

  describe "code" do
    let(:source_code) { strip_comments(File.read("contact_card.rb")) }

    it "uses a symbol-keyed hash", points: 1 do
      # Accepts both styles: { name: "Ari" } or { :name => "Ari" }
      expect(source_code).to match(/\{\s*(?:[a-zA-Z_]\w*\s*:|:[a-zA-Z_]\w*\s*=>)/),
        "Use symbols for the keys in the hash (e.g., { name: \"Ari\" } or { :name => \"Ari\" })"
    end

    it "creates a hash named 'contact'", points: 1 do
      # Allows either a literal {} or Hash.new
      expect(source_code).to match(/^\s*contact\s*=\s*(\{|\bHash\.new\b)/m),
        "Define a variable named `contact` and assign a hash to it"
    end


    it "uses string interpolation", points: 1 do
      # Require at least one #{...} inside a double-quoted string
      expect(source_code).to match(/"[^"\n]*\#\{[^}]+\}[^"\n]*"/),
        "Build your output using a double-quoted string with \#{...} interpolation"
    end
  end
end
