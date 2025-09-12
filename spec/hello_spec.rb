# spec/hello_spec.rb

RSpec.describe "hello.rb" do
  describe "output" do
    it "outputs 'hello, world'", points: 1 do
      output = run_script_and_capture_lines("hello.rb")
  
      expect(output).to eq("hello, world")
    end
  end
end
