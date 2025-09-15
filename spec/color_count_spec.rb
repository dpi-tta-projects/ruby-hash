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

    it "uses Hash.new(0)", points: 1 do
      expect(source_code).to match(/Hash\.new\(0\)/)
    end

    it "uses .each for iteration", points: 1 do
      expect(source_code).to match(/\.\s*each\s*(?:do|\{)\s*\|/)
    end

    it "uses pretty print (pp)", points: 1 do
      expect(source_code).to match(/\bpp\b/)
    end

    describe "no hard-coding; derives output from a counter hash" do
      # Capture the counter hash variable name (any variable name).
      let(:counter_var) do
        m = source_code.match(/^\s*(\w+)\s*=\s*Hash\.new\(0\)/)
        m && m[1]
      end

      # Capture the block variable used in `.each`.
      let(:block_var) do
        m = source_code.match(/\.each\s*(?:do|\{)\s*\|\s*(\w+)\s*\|/)
        m && m[1]
      end

      it "assigns Hash.new(0) to a variable and increments it inside the .each block", points: 1 do
        expect(counter_var).to be_a(String),
          "Assign Hash.new(0) to a variable (e.g., counts = Hash.new(0))"

        expect(block_var).to be_a(String),
          "Iterate over the colors array with .each and a block variable (e.g., .each do |color|)"

        # Ensure increment uses the block variable as the key and happens within the each block
        expect(source_code).to match(
          /\.each\s*(?:do|\{)\s*\|\s*#{block_var}\s*\|.*#{counter_var}\s*\[\s*#{block_var}\s*\]\s*\+\=\s*1/m
        ), "Increment the counter inside the loop (e.g., #{counter_var}[#{block_var}] += 1)"
      end

      it "prints each expected line using interpolation from the counter hash (not literals)", points: 1 do
        %w[red blue green].each do |color|
          # Accept string or symbol key inside interpolation: counter["red"] or counter[:red]
          pattern = /\bpp\b.*"[^"\n]*\#\{\s*#{counter_var}\s*\[\s*(?::#{color}|["']#{color}["'])\s*\]\s*\}[^"\n]*"/m
          expect(source_code).to match(pattern),
            "Use interpolation from the counter hash for #{color} (e.g., pp \"#{color} \#{#{counter_var}[:#{color}]}\")"
        end
      end

      it "does not hard-code the final strings", points: 1 do
        { "red" => 2, "blue" => 1, "green" => 1 }.each do |color, n|
          # Disallow exact string literals like "red 2"
          expect(source_code).not_to match(/["']#{color}\s+#{n}["']/),
            "Don't hard-code \"#{color} #{n}\"; derive it from the counter hash"
        end
      end
    end
  end
end
