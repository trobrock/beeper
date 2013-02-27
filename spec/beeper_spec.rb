require File.join(File.dirname(__FILE__), 'spec_helper')

describe Beeper do
  it "should be able to configure itself" do
    client = Beeper.configure do |c|
      c.api_key   = "00000000000"
      c.subdomain = "testdomain"
    end

    client.configured?.should == true
  end

  it "should use https by default" do
    client = Beeper.configure do |c|
      c.api_key   = "00000000000"
      c.subdomain = "testdomain"
    end

    client.use_ssl.should == true
  end

  it "should be able to use http" do
    client = Beeper.configure do |c|
      c.api_key   = "00000000000"
      c.subdomain = "testdomain"
      c.use_ssl   = false
    end

    client.use_ssl.should == false
  end
end
