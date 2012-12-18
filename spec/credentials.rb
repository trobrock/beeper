module Beeper
  class Test
    API_KEY      = ENV["PAGERDUTY_API_KEY"]      || "000000000000000"
    REQUESTER_ID = ENV["PAGERDUTY_REQUESTER_ID"] || "000000"
  end
end
