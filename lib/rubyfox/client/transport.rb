require 'rubyfox/client/java'
require 'rubyfox/client/config'
require 'rubyfox/client/request'
require 'rubyfox/client/event_handler'
require 'rubyfox/client/extension_handler'

module Rubyfox
  module Client
    class Transport
      def initialize(config)
        @config             = config
        @smartfox           = Java::SmartFox.new(@config.debug?)
        @event_handler      = EventHandler.new(@smartfox)
        @extension_handler  = ExtensionHandler.new(@event_handler)
        if block_given?
          yield self
          connect
        end
      end

      def connect
        @event_handler.register
        @extension_handler.register
        @smartfox.connect(@config.host, @config.port)
        sleep 0.1
      end

      def disconnect
        @smartfox.disconnect
        @extension_handler.unregister
        @event_handler.unregister
      end

      def exit(ret=0)
        disconnect
        Java::System.exit(ret)
      end

      def send(command, *args)
        request = Request[command].new(*args)
        @smartfox.send(request)
      end

      def send_extension(command, params=nil, room=nil)
        send :extension, command.to_s, params, room
      end

      def on_extension(*commands, &block)
        @extension_handler.add(*commands, &block)
      end

      def remove_extension(*commands)
        @extension.remove(*commands)
      end

      def on_event(*names, &block)
        @event_handler.add(*names, &block)
      end

      def remove_event(*names)
        @event_handler.remove(*names)
      end
    end
  end
end
