require "beeper/version"
require "beeper/client"

module Beeper
  def self.configure
    client = Client.new
    yield client
    client
  end
end
