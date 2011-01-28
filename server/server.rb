require 'rubygems'
require 'em-websocket'
 
puts 'server start'

EM::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
  ws.onopen{
    puts "connect client"
    ws.send "Hello Client!"
  }
  ws.onmessage{|msg|
    puts msg
    ws.send "Pong: #{msg}"
  }
  ws.onclose{
    puts "WebSocket closed"
  }
end
