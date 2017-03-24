module AkamaiRestCcu
  module Errors
    class HTTPBasicErrors < StandardError; end

    class RequestEntityTooLarge < HTTPBasicErrors; end # 413
    class TooManyRequests < HTTPBasicErrors; end # 429
    class Insufficient < HTTPBasicErrors; end # 507
  end
end
