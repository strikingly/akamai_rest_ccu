require 'akamai_rest_ccu/version'
require 'json'
require 'akamai/edgegrid'
require 'net/http'
require 'uri'

module AkamaiRestCcu
  class Ccu
    def initialize(opts)
      @base_uri = URI(opts[:base_uri])
      @http = Akamai::Edgegrid::HTTP.new(
        @base_uri.host,
        @base_uri.port
      )
      @http.setup_edgegrid(
        client_token: opts[:client_token],
        client_secret: opts[:client_secret],
        access_token: opts[:access_token],
        max_body: 128*1024
      )
    end

    def purge_url(url, opts={})
      purge(
        type: :url,
        url: url,
        objects: opts[:objects] || ['/']
      )
    end

    def purge_urls(urls, opts={})
      urls.each { |url| purge_url(url, opts) }
    end

    def purge_cpcodes(cpcodes)
      purge(
        type: :cpcode,
        objects: cpcodes
      )
    end

    def purge(opts)
      type = opts[:type] || :url

      post_request = Net::HTTP::Post.new(
        URI.join(@base_uri.to_s, "/ccu/v3/invalidate/#{type}").to_s,
        {'Content-Type' => 'application/json'}
      )

      post_request.body = if type == :url
                            {
                              'hostname' => opts[:url],
                              'objects' => opts[:objects] || ['/']
                            }.to_json
                          elsif type == :cpcode
                            {'objects' => opts[:objects]}.to_json
                          end
      @http.request(post_request)
    end
  end
end
