require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
# ^ Must go first: https://codeclimate.com/repos/52e2cff26956803493005536/coverage_setup

require 'bundler/setup'
require 'json'

Bundler.require(:development)

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

SimpleCov.start

require 'middleman_writer'

RSpec.configure do |config|
  config.include FixturesHelpers
  config.add_setting :spec_root, default: File.dirname(__FILE__)
end
