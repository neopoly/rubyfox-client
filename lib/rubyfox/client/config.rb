module Rubyfox
  module Client
    class Config
      def initialize(options = {})
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

      def http_port
        @options[:http_port] || 8080
      end

      def https_port
        @options[:https_port] || 8443
      end

      def zone
        @options[:zone] || ""
      end
    end
  end
end
