require "rubyfox/client/java"

module Rubyfox
  module Client
    Event = Java::SFSEvent

    class Event
      self.__persistent__ = true

      def self.types(&block)
        constants
      end

      def self.[](name)
        const_get(name.to_s.upcase)
      end

      def params
        @params ||= EventParams.new(arguments)
      end

      def inspect
        "#{super}: #{type}(#{arguments.inspect})"
      end
    end

    class EventParams
      include Enumerable

      def initialize(hash)
        @hash = hash
      end

      def [](key)
        @hash[key.to_s]
      end

      def each(&block)
        @hash.each(&block)
      end

      def inspect
        @hash.inspect
      end
    end
  end
end
