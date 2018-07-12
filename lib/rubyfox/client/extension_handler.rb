module Rubyfox
  module Client
    class ExtensionHandler
      Request = Struct.new(:command, :params, :room, :packet_id)

      def initialize(event_handler)
        @handler = Hash.new { |hash, type| hash[type] = [] }
        @event_handler = event_handler
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
          @handler[resolve_command(name)] << block
        end
      end

      def remove(*names)
        names.each do |name|
          @handler[resolve_command(name)].clear
        end
      end

      def dispatch(request)
        command = request.command

        handlers = @handler[:any] + @handler[command]
        handlers.each do |handler|
          handler.call(request)
        end
      end

      private

      def resolve_command(name)
        if name == :any
          name
        else
          name.to_s
        end
      end
    end
  end
end
