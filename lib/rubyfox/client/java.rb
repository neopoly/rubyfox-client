require "java"

module Rubyfox
  module Client
    module Java
      SmartFox = ::Java.sfs2x.client.SmartFox
      Request = ::Java.sfs2x.client.requests
      SFSEvent = ::Java.sfs2x.client.core.SFSEvent
      System = ::Java.java.lang.System
      ConfigData = ::Java::sfs2x.client.util.ConfigData
    end
  end
end
