require "java"

module Rubyfox
  SFSObject = com.smartfoxserver.v2.entities.data.SFSObject

  class Handler
    def initialize(extension)
      @extension = extension
    end

    def on_init
      @extension.trace "examples extension ready"
    end

    def on_request(command, user, params)
      case command
      when "KeepAlive"
        response = SFSObject.new_instance
        response.put_int "next_in", 5
        @extension.send "KeepAlive", response, user
      end
    end

    def on_event(event)
    end

    def on_destroy
    end
  end

  def self.init(extension)
    Handler.new(extension)
  end
end
