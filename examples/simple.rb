require 'rubyfox/client'

ARGV.size == 3 or abort "usage: simple.rb username password zone"

Rubyfox::Client.boot!

client = Rubyfox::Client.new
client.on_event :connection do |event|
  p :connected!
  client.send :login, *ARGV
end
client.on_event :login do |event|
  p :login => event.params[:zone]
  client.disconnect
end
client.on_event :login_error do |event|
  p :login_failed
  client.disconnect
end
client.on_event :connection_lost do |event|
  p :disconnected
  client.exit
end
client.connect
