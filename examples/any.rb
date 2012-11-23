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
  client.on_event :connection do
    client.send :login, *ARGV
  end

  client.on_event :connection_attempt_http, :connection_resume, :connection_retry do |event|
  end

  client.on_event :login do |event|
    p :login => event
    client.send_extension "KeepAlive"
  end

  client.on_event :login_error, :connection_lost, :logout do |event|
    p :out => event
    client.exit
  end

  client.on_extension "KeepAlive" do |request|
    client.disconnect
  end

  client.on_event :any do |event|
    p :any_event => event
  end

  client.on_extension :any do |request|
    p :any_request => request
  end
end
