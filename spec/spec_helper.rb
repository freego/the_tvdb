require_relative '../lib/the_tvdb'
# For Ruby < 1.9.3, use this instead of require_relative
# require(File.expand_path('../../lib/dish', __FILE__))

#require 'rspec'
require 'rspec/autorun'
require 'webmock/rspec'
require 'vcr'

#VCR config
VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/tvdb_cassettes'
  config.hook_into :webmock
end

TheTvdb.setup do |config|
  config.api_key = '1234567898765432'
end
