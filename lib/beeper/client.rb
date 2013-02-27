require 'faraday'
require 'faraday_middleware'

module Beeper
  class Client
    COLLECTIONS = [:incidents, :services, :maintenance_windows].freeze

    attr_accessor :api_key, :subdomain, :requester_id, :secure

    def initialize
      @secure = true
    end

    def configured?
      !@api_key.nil? && !@subdomain.nil?
    end

    COLLECTIONS.each do |collection|
      class_eval <<-RB
        def #{collection}(options={})
          get(:#{collection}, options)
        end
      RB
    end

    def create_maintenance_window(maintenance_window)
      post(:maintenance_windows, maintenance_window)
    end

    def delete_maintenance_window(id)
      delete(:maintenance_windows, { :id => id })
    end

    private

    def get(collection, options={})
      results = connection.get(collection.to_s, options)
      results.body.send(collection.to_sym)
    end

    def post(collection, options={})
      single_collection = collection.to_s[0..-2]
      options = authenticated_post_options.merge(single_collection.to_sym => options)

      results = connection.post(collection.to_s, options)
      results.body.send(single_collection.to_sym)
    end

    def delete(collection, options={})
      id = options.delete(:id)
      results = connection.delete("#{collection}/#{id}", options)
      results.success?
    end

    def authenticated_post_options
      {
        :requester_id => @requester_id
      }
    end

    def protocol
      secure ? "https" : "http"
    end

    def connection
      @connection ||= Faraday.new("#{protocol}://#@subdomain.pagerduty.com/api/v1") do |conn|
        conn.request :json
        conn.token_auth @api_key

        conn.response :rashify
        conn.response :json, :content_type => /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end

  end
end
