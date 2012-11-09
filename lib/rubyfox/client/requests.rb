require 'active_support/core_ext/string/inflections'
require 'rubyfox/client/java'

module Rubyfox
  module Client
    Requests = Java::Requests

    module Requests
      def self.[](*args)
        arg = args.shift
        case arg
        when Java::Requests::BaseRequest
          arg
        else
          name = arg.to_s.camelcase
          name += "Request" unless name.end_with?("Request")
          request_klass = Requests.__send__(name)
          request_klass.new(*args)
        end
      end
    end
  end
end
