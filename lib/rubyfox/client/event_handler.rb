require 'rubyfox/client/event'

module Rubyfox
  module Client
    class EventHandler
      def initialize(smartfox)
        @handler  = Hash.new { |hash, type| hash[type] = [] }
        @smartfox = smartfox
      end

      def register
        Event.types.each do |type|
          @smartfox.add_event_listener Event[type], self
        end
      end

      def unregister
        @smartfox.remove_all_event_listeners
      end

      def add(*names, &block)
        names.each do |name|
          @handler[event_type(name)] << block
        end
      end

      def remove(*names)
        names.each do |name|
          @handler[event_type(name)].clear
        end
      end

      def dispatch(event)
        type = event.type

        handlers = @handler[:any] + @handler[type]
        handlers.each do |handler|
          handler.call(event)
        end
      end

      private

      def event_type(name)
        if name == :any
          name
        else
          Event[name]
        end
      end
    end
  end
end
