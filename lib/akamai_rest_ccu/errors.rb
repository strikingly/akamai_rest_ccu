module AkamaiRestCcu
  module Errors
    class HTTPErrors < StandardError; end

    class BadRequest < HTTPErrors; end # 400
    class Unauthorized < HTTPErrors; end # 401
    class Forbidden < HTTPErrors; end # 403
    class RequestEntityTooLarge < HTTPErrors; end # 413
    class UnsupportedMediaType < HTTPErrors; end # 415
    class TooManyRequests < HTTPErrors; end # 429
    class HTTPInternalServerError < HTTPErrors; end # 500
    class Insufficient < HTTPErrors; end # 507
  end
end
