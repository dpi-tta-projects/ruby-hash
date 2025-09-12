require "bundler/setup"   # !important so the Gemfile dependencies are on $LOAD_PATH
require "grade_runner/test_helpers"

RSpec.configure do |config|
  config.include GradeRunner::TestHelpers
end
