require "active_support/core_ext/string/inflections"
require "rubyfox/client/java"

module Rubyfox
  module Client
    Request = Java::Request

    module Request
      def self.[](name)
        case name
        when Request::BaseRequest
          name
        else
          name = name.to_s.camelcase
          name += "Request" unless name.end_with?("Request")
          Request.__send__(name)
        end
      end
    end
  end
end
