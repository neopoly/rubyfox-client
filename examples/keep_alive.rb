require 'rubyfox/client'

unless ARGV.size == 3
  abort "usage: #{$0} username password zone"
end

unless ENV['SF_DIR']
  abort "Point SF_DIR to your SmartFox installation"
end

Rubyfox::Client.require_libs(ENV['SF_DIR'] + "/lib")
Rubyfox::Client.boot!

Rubyfox::Client.new(:debug => true) do |client|
  p :here
  client.on_event :connection do
    client.send :login, *ARGV
  end

  client.on_event :connection_attempt_http, :connection_resume, :connection_retry do |event|
    p :problems => event
  end

  client.on_event :login do |event|
    p :login => event
    client.send_extension "KeepAlive"
  end

  client.on_event :login_error, :connection_lost, :logout do |event|
    p event
    client.exit
  end

  client.on_extension "KeepAlive" do |request|
    p request
    next_in = request.params.get_int("next_in")
    Thread.start do
      sleep next_in
      client.send_extension "KeepAlive"
    end
  end
end
