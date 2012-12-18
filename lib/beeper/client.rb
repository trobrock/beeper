module Beeper
  class Client
    attr_accessor :api_key

    def configured?
      !@api_key.nil?
    end

  end
end
