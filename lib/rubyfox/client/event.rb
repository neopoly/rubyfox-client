require 'rubyfox/client/java'

module Rubyfox
  module Client
    Event = Java::SFSEvent

    class Event
      def self.types(&block)
        constants
      end

      def self.[](name)
        const_get(name.to_s.upcase)
      end

      def method_missing(name, *args, &block)
        self[name]
      end

      def inspect
        "#{super}: #{type}(#{arguments.inspect})"
      end
    end
  end
end
