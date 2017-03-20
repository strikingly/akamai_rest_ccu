module AkamaiRestCcu
  module V3
    class Client
      def initialize(opts)
        @connection = Connection.new(opts)
      end

      def purge(objects, opts = {})
        opts = opts.dup
        objects = if objects.is_a?(Array)
                    objects.dup
                  else
                    [objects]
                  end
        network = opts.fetch(:network, :production)

        @connection.post("/ccu/v3/invalidate/url/#{network}",
                         { objects: objects })
      end
    end
  end
end
