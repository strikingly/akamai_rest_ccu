require 'json'
require 'uri'
require 'net/http'

module AkamaiRestCcu
  class Connection
    def initialize(opts = {})
      opts = opts.dup
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

    def get(path)
      request = Net::HTTP::Get.new(
        URI.join(@base_uri.to_s, path).to_s,
        { 'Content-Type' => 'application/json' }
      )
      send_req(request)
    end

    def post(path, payload = {})
      request = Net::HTTP::Post.new(
        URI.join(@base_uri.to_s, path).to_s,
        { 'Content-Type' => 'application/json' }
      )
      request.body = payload.to_json
      send_req(request)
    end

    private

    def send_req(request)
      response = @http.request(request)
      case response
      when Net::HTTPBadRequest
        raise Errors::BadRequest, response.body
      when Net::HTTPUnauthorized
        raise Errors::Unauthorized, response.body
      when Net::HTTPForbidden
        raise Errors::Forbidden, response.body
      when Net::HTTPRequestEntityTooLarge
        raise Errors::RequestEntityTooLarge, response.body
      when Net::HTTPTooManyRequests
        raise Errors::TooManyRequests, response.body
      when Net::HTTPInsufficientStorage
        raise Errors::Insufficient, response.body
      when Net::HTTPUnsupportedMediaType
        raise Errors::UnsupportedMediaType, response.body
      when Net::HTTPInternalServerError
        raise Errors::HTTPInternalServerError, response.body
      end
      response.body
    end
  end
end
