module AkamaiRestCcu
  module V2
    class Client
      def initialize(opts = {})
        @connection = Connection.new(opts)
      end

      def purge_status(purge_id)
        @connection.get("/ccu/v2/purges/#{purge_id}")
      end

      def queue_size(queue = :default)
        queue = [:default, :emergency].include?(queue) ? queue : :default

        @connection.get("/ccu/v2/queues/#{queue}")
      end

      def purge(objects, opts = {})
        objects = [objects] unless objects.is_a?(Array)
        action = opts.fetch(:action, :remove)
        domain = opts.fetch(:domain, :production)
        type = opts.fetch(:type, :arl)
        queue = opts.fetch(:queue, :default)

        @connection.post("ccu/v2/queues/#{queue}", {
          objects: objects,
          action: action,
          type: type,
          domain: domain
        })
      end
    end
  end
end
