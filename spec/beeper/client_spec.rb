require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Beeper::Client do
  use_vcr_cassette

  let(:client) do
    Beeper.configure do |c|
      c.api_key = Beeper::Test::API_KEY
      c.subdomain = "outright"
    end
  end

  it "should be able to list incidents" do
    client.incidents.size.should == 2
  end

  it "should be able to list services" do
    client.services.should == services
  end

  describe "maintenance windows" do
    it "should be able to list" do
      client.maintenance_windows.should == []
    end

    it "should be able to list by type" do
      client.maintenance_windows(:type => :future).should == future_maintenance
    end

    it "should be able to create" do
      client = Beeper.configure do |c|
        c.api_key = Beeper::Test::API_KEY
        c.subdomain = "outright"
        c.requester_id = Beeper::Test::REQUESTER_ID
      end

      client.create_maintenance_window(
        :start_time => Time.now,
        :end_time => Time.now + 3600,
        :service_ids => ["POM55DP"]
      ).should == new_maintenance_window
    end
  end
end

def new_maintenance_window
  {
    "maintenance_window" => {
      "id"=>"P89LAYQ",
      "sequence_number"=>1,
      "start_time"=>"2012-12-18T14:34:16-08:00",
      "end_time"=>"2012-12-18T15:34:15-08:00",
      "description"=>nil,
      "created_by"=>{
        "id"=>"PR55CF0",
        "name"=>"Bob Smith",
        "email"=>"bob@example.com",
        "time_zone"=>"Pacific Time (US & Canada)",
        "color"=>"green",
        "role"=>"admin",
        "avatar_url"=>"https://secure.gravatar.com/avatar/71c3bbda60a46a241bf9a2d68e41cbec.png?d=mm&r=PG",
        "user_url"=>"/users/PR55CF0",
        "invitation_sent"=>false,
        "marketing_opt_out"=>false
      },
      "services"=>[
        {
          "id"=>"POM55DP",
          "name"=>"Application",
          "service_url"=>"/services/POM55DP",
          "service_key"=>"application@outright.pagerduty.com",
          "auto_resolve_timeout"=>14400,
          "acknowledgement_timeout"=>600,
          "created_at"=>"2012-12-01T13:59:54-08:00",
          "status"=>"maintenance",
          "last_incident_timestamp"=>nil,
          "email_incident_creation"=>"on_new_email_subject",
          "incident_counts"=>{"triggered"=>0, "acknowledged"=>0, "resolved"=>0, "total"=>0},
          "email_filter_mode"=>"all-email",
          "type"=>"pingdom"
        }
      ]
    }
  }
end

def services
  [
    Hashie::Rash.new({
      "id"=>"POM55DP",
      "name"=>"Pingdom Aggregation",
      "service_url"=>"/services/POM55DP",
      "service_key"=>"aggregation@outright.pagerduty.com",
      "auto_resolve_timeout"=>14400,
      "acknowledgement_timeout"=>600,
      "created_at"=>"2012-12-01T13:59:54-08:00",
      "status"=>"active",
      "last_incident_timestamp"=>nil,
      "email_incident_creation"=>"on_new_email_subject",
      "incident_counts"=>{"triggered"=>0, "acknowledged"=>0, "resolved"=>0, "total"=>0},
      "email_filter_mode"=>"all-email",
      "type"=>"pingdom"
    }),
    Hashie::Rash.new({
      "id"=>"PW7E752",
      "name"=>"Pingdom Application",
      "service_url"=>"/services/PW7E752",
      "service_key"=>"application@outright.pagerduty.com",
      "auto_resolve_timeout"=>14400,
      "acknowledgement_timeout"=>600,
      "created_at"=>"2012-12-01T13:51:47-08:00",
      "status"=>"active",
      "last_incident_timestamp"=>nil,
      "email_incident_creation"=>"on_new_email_subject",
      "incident_counts"=>{"triggered"=>0, "acknowledged"=>0, "resolved"=>0, "total"=>0},
      "email_filter_mode"=>"all-email",
      "type"=>"pingdom"
    })
  ]
end

def future_maintenance
  [
    {
      "id"=>"PW4ICCT",
      "sequence_number"=>1,
      "start_time"=>"2012-12-18T16:00:00-08:00",
      "end_time"=>"2012-12-18T17:00:00-08:00",
      "description"=>"testing",
      "created_by"=>
      {
        "id"=>"PR55CF0",
        "name"=>"Bob Smith",
        "email"=>"bob@example.com",
        "time_zone"=>"Pacific Time (US & Canada)",
        "color"=>"green",
        "role"=>"admin",
        "avatar_url"=>
        "https://secure.gravatar.com/avatar/71c3bbda60a46a241bf9a2d68e41cbec.png?d=mm&r=PG",
          "user_url"=>"/users/PR55CF0",
          "invitation_sent"=>false,
          "marketing_opt_out"=>false
      },
      "services"=>[
        {
          "id"=>"PZ9VM86",
          "name"=>"Application",
          "service_url"=>"/services/PZ9VM86",
          "service_key"=>"application@outright.pagerduty.com",
          "auto_resolve_timeout"=>14400,
          "acknowledgement_timeout"=>600,
          "created_at"=>"2012-03-07T15:44:09-08:00",
          "status"=>"active",
          "last_incident_timestamp"=>"2012-12-17T09:11:11-08:00",
          "email_incident_creation"=>"on_new_email_subject",
          "incident_counts"=>{"triggered"=>0, "acknowledged"=>0, "resolved"=>166, "total"=>166},
          "email_filter_mode"=>"all-email",
          "type"=>"generic_email"
        }
      ]
    }
  ]
end
