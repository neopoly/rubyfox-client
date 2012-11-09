module Rubyfox
  module Client
    def self.new(*args)
      config = Config.new(*args)
      Transport.new(config)
    end

    def self.boot!(vendor_dir=File.expand_path('client/vendor', File.dirname(__FILE__)))
      require_libs vendor_dir

      require 'rubyfox/client/transport'
      require 'rubyfox/client/event_handler'
    end

    def self.require_libs(dir)
      glob = File.join(dir, '*.jar')
      libs = Dir[glob].to_a
      if libs.empty?
        abort "No libs to require for #{glob}"
      end
      libs.each { |lib| require lib }
    end
  end
end
