require 'simplecov'
require 'coveralls'
if ENV['TRAVIS']
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
else
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
end
SimpleCov.start
# ^ Needs to be at the top

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
