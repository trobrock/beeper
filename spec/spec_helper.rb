require 'coveralls'
Coveralls.wear!

require "beeper"
require "mocha/api"
require "vcr"

require "credentials"

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  config.mock_framework = :mocha
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday, :webmock

  # Add sensitive fields here
  # Constants in Etsy::Test will be auto filtered
  Beeper::Test.constants.reverse.each do |const|
    c.filter_sensitive_data(const.to_s) { Beeper::Test.const_get(const) }
  end
end
