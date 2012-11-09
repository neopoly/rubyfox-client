module Rubyfox
  module Client
    class ExtensionHandler
      Request = Struct.new(:command, :params, :room, :packet_id)

      def initialize(event_handler)
        @handler        = Hash.new { |hash, type| hash[type] = [] }
        @event_handler  = event_handler
      end

      def register
        @event_handler.add(:extension_response) do |event|
          request = Request.new(*event.arguments.values_at("cmd", "params", "sourceRoom", "packetId"))
          dispatch(request)
        end
      end

      def unregister
        @event_handler.remove(:extension_response)
      end

      def add(*names, &block)
        names.each do |name|
          @handler[name.to_s] << block
        end
      end

      def remove(*names)
        names.each do |name|
          @handler[name.to_s].clear
        end
      end

      def dispatch(request)
        command = request.command

        @handler[command].each do |handler|
          handler.call(request)
        end
      end
    end
  end
end
