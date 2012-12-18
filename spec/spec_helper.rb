require "beeper"
require "webmock/rspec"
require "mocha_standalone"
require "uri"
require "cgi"

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  config.mock_framework = :mocha
end
