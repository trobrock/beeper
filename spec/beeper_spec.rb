require File.join(File.dirname(__FILE__), 'spec_helper')

describe Beeper do
  it "should be able to configure itself" do
    client = Beeper.configure do |c|
      c.api_key = "00000000000"
    end

    client.configured?.should == true
  end
end
