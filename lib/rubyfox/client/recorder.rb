require 'timeout'
require 'rubyfox/client/event'

module Rubyfox
  module Client
    # Records all incoming and outgoing events, requests and extension requests
    # for test purposes.
    #
    # == Example
    #
    #   client = Rubyfox::Client.new
    #   recorder = Rubyfox::Rubyfox::Recorder.new(client)
    #
    #   client.connect
    #   client.send :login, "username", "password", "zone"
    #   client.disconnect
    #
    #   assert_equal 1, recorder.events(:connection).size
    #   assert_equal 1, recorder.events(:login).size
    #   assert_equal 1, recorder.extensions("Me.User").size
    #   assert_equal 1, recorder.events(:connection_lost).size
    class Recorder
      include Timeout

      def initialize(client)
        @client     = client
        @events     = Hash.new { |hash, type| hash[type] = [] }
        @extensions = Hash.new { |hash, command| hash[command] = [] }
        @connection_lost = false
        install_callbacks
      end

      def events(name)
        type = Event[name]
        @events[type]
      end

      def extensions(command)
        @extensions[command]
      end

      def verify(options={}, &block)
        @client.connect
        wait = options[:timeout] || 1
        timeout wait do
          while not @connection_lost
            sleep 0.1
          end
        end
      rescue Timeout::Error
        # ignore
      ensure
        yield
      end

      private

      def install_callbacks
        @client.on_event(:any) do |event|
          record_event(event)
        end

        @client.on_extension(:any) do |extension|
          record_extension(extension)
        end

        @client.on_event(:connection_lost) do |event|
          @connection_lost = true
        end
      end

      def record_event(event)
        @events[event.type] << event
      end

      def record_extension(extension)
        @extensions[extension.command] << extension
      end
    end
  end
end
