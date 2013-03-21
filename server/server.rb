require 'rubygems'
require 'bundler'
require 'em-websocket'

MAX_LOG = 100
PORT = 8080

EM::run do

  puts "start websocket server - port:#{PORT}"
  @channel = EM::Channel.new
  @logs = Array.new
  @channel.subscribe{|mes|
    @logs.push mes
    @logs.shift if @logs.size > MAX_LOG
  }

  EM::WebSocket.start(:host => "0.0.0.0", :port => PORT) do |ws|
    ws.onopen{
      sid = @channel.subscribe{|mes|
        ws.send(mes)
      }
      puts "<#{sid}> connected!!"
      @logs.each{|mes|
        ws.send(mes)
      }
      @channel.push("hello <#{sid}>")

      ws.onmessage{|mes|
        puts "<#{sid}> #{mes}"
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
      sleep 60*60*3
    end
  end
end
