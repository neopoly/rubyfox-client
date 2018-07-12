require "dry/inflector"
require "rubyfox/client/java"

module Rubyfox
  module Client
    Request = Java::Request

    module Request
      Inflector = Dry::Inflector.new

      def self.[](name)
        case name
        when Request::BaseRequest
          name
        else
          name = Inflector.camelize(name.to_s)
          name += "Request" unless name.end_with?("Request")
          Request.__send__(name)
        end
      end
    end
  end
end
