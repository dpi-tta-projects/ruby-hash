# spec/color_count_spec.rb
RSpec.describe "color_count.rb" do
  describe "output" do
    it "prints counts for red, blue, and green", points: 3 do
      output = run_script_and_capture_lines("color_count.rb")

      expect(output).to include("red 2", "blue 1", "green 1")
      expect(output.length).to eq(3)
    end
  end

  describe "code" do
    let(:source_code) { strip_comments(File.read("color_count.rb")) }

    it "uses Hash.new(0)", points: 2 do
      expect(source_code).to match(/Hash\.new\(0\)/)
    end

    it "uses .each for iteration", points: 1 do
      expect(source_code).to match(/\.\s*each\s+do\s*\|/)
    end

    it "uses pretty print (pp)", points: 1 do
      expect(source_code).to match(/\bpp\b/)
    end
  end
end
