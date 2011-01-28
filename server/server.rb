require 'rubygems'
require 'em-websocket'
 
puts 'server start'

EM::run do

  @channel = EM::Channel.new

  EM::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen{
      sid = @channel.subscribe{|mes|
        ws.send(mes)
      }
      puts "<#{sid}> connected!!"
      @channel.push("hello <#{sid}>")

      ws.onmessage{|mes|
        puts "<#{sid}> mes"
        @channel.push("<#{sid}> #{mes}")
      }

      ws.onclose{
        puts "<#{sid}> disconnected"
        @channel.unsubscribe(sid)
        @channel.push("<#{sid}> disconnected")
      }
    }
  end

  EM::defer do
    loop do
      puts Time.now.to_s
      @channel.push Time.now.to_s
      sleep 10
    end
  end
end
