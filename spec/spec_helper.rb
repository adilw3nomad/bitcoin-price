ENV['RACK_ENV'] = 'test'
$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..', 'app')))

require 'minitest/autorun'
require 'controllers/application_controller'
require 'webmock/minitest'
require 'vcr'
require 'minitest/reporters'

Minitest::Reporters.use!
# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/dish_cassettes'
  c.hook_into :webmock
end
