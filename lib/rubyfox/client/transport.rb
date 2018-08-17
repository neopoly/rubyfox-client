require "rubyfox/client/java"
require "rubyfox/client/config"
require "rubyfox/client/request"
require "rubyfox/client/event_handler"
require "rubyfox/client/extension_handler"

module Rubyfox
  module Client
    class Transport
      def initialize(config)
        @config = config
        @smartfox = Java::SmartFox.new(@config.debug?)
        @event_handler = EventHandler.new(@smartfox)
        @extension_handler = ExtensionHandler.new(@event_handler)
        if block_given?
          yield self
          connect
        end
      end

      def connect
        @event_handler.register
        @extension_handler.register

        config_data = Java::ConfigData.new
        config_data.host = @config.host
        config_data.port = @config.port
        config_data.http_port = @config.http_port
        config_data.https_port = @config.https_port
        config_data.zone = @config.zone

        @smartfox.connect(config_data)
        sleep 0.1
      end

      def connected?
        @smartfox.connected?
      end

      def disconnect
        @smartfox.disconnect
        @extension_handler.unregister
        @event_handler.unregister
      end

      def exit(ret = 0)
        disconnect
        Java::System.exit(ret)
      end

      def send(command, *args)
        request = Request[command].new(*args)
        @smartfox.send(request)
      end

      def send_extension(command, params = nil, room = nil)
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

      def init_crypto
        @smartfox.init_crypto
      end
    end
  end
end
