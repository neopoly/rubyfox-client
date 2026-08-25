require "dry/inflector"
require "rubyfox/client/java"

module Rubyfox
  module Client
    Request = Java::Request

    def self.inflector
      @inflector ||= Dry::Inflector.new
    end

    module Request
      def self.[](name)
        case name
        when Request::BaseRequest
          name
        else
          name = Client.inflector.camelize(name.to_s)
          name += "Request" unless name.end_with?("Request")
          Request.__send__(name)
        end
      end
    end
  end
end
