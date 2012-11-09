module Rubyfox
  module Client
    class Config
      def initialize(options={})
        @options = options
      end

      def host
        @options[:host] || "127.0.0.1"
      end

      def port
        @options[:port] || 9933
      end

      def debug?
        @options[:debug] || false
      end

      def udp?
        false
      end

      def bluebox?
        false
      end

      def bluebox_port
      end
    end
  end
end
