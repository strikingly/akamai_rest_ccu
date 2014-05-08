require "akamai_rest_ccu/version"
require 'rest_client'
require 'json'

module AkamaiRestCcu
  class Ccu
    def initialize(username, password)
      @username = username
      @password = password
      @base_url = "https://#{@username}:#{@password}@api.ccu.akamai.com"
    end

    def purge_urls(urls, opt = {})
      url = "#{@base_url}/ccu/v2/queues/default"
      params = {
        :objects => urls
      }.merge(opt)
      response = RestClient.post url, params.to_json, :content_type => :json
      JSON.load(response)
    end

    def purge_cpcodes(cpcodes, opt = {})
      url = "#{@base_url}/ccu/v2/queues/default"
      params = {
        :type => "cpcode",
        :objects => cpcodes
      }.merge(opt)
      response = RestClient.post url, params.to_json, :content_type => :json
      JSON.load(response)
    end

    def purge_status(progress_uri)
      url = "#{@base_url}#{progress_uri}"
      response = RestClient.get url
      JSON.load(response)
    end

    def queue_length
      url = "#{@base_url}/ccu/v2/queues/default"
      response = RestClient.get url
      JSON.load(response)
    end
  end
end
