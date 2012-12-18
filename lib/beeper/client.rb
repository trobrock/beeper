require 'faraday'
require 'faraday_middleware'

module Beeper
  class Client
    attr_accessor :api_key, :subdomain, :requester_id

    def configured?
      !@api_key.nil? && !@subdomain.nil?
    end

    def incidents
      get(:incidents)
    end

    def services
      get(:services)
    end

    def maintenance_windows(options={})
      get(:maintenance_windows, options)
    end

    def create_maintenance_window(maintenance_window)
      post(:maintenance_windows, maintenance_window)
    end

    private

    def get(collection, options={})
      results = connection.get(collection.to_s, options)
      results.body.send(collection.to_sym)
    end

    def post(collection, options={})
      options = authenticated_post_options.merge(collection[0..-2].to_sym => options)

      results = connection.post(collection.to_s, options)
      results.body
    end

    def authenticated_post_options
      {
        :requester_id => @requester_id
      }
    end

    def connection
      @connection ||= Faraday.new("https://#@subdomain.pagerduty.com/api/v1") do |conn|
        conn.request :json
        conn.token_auth @api_key

        conn.response :rashify
        conn.response :json, :content_type => /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end

  end
end
