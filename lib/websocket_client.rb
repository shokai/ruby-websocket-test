require 'websocket'
require 'socket'
require 'uri'
require 'event_emitter'

class WebSocketClient
  include EventEmitter

  def initialize(url)
    uri = URI.parse url
    @socket = TCPSocket.new(uri.host, uri.port || 80)
    @hs = ::WebSocket::Handshake::Client.new :url => url
    handshaked = false
    frame = ::WebSocket::Frame::Incoming::Client.new
    @closed = false
    Thread.new do
      while !@closed do
        recv_data = @socket.getc
        if !handshaked
          @hs << recv_data
          handshaked = true if @hs.finished?
        else
          frame << recv_data
          while msg = frame.next
            emit :data, msg.data
          end
        end
        sleep 0.001
      end
    end

    @socket.write @hs.to_s
    
  end

  def send(data)
    frame = ::WebSocket::Frame::Outgoing::Client.new(:data => data, :type => :text, :version => @hs.version)
    @socket.write frame.to_s
  end

  def close
    @closed = true
    @socket.close
  end

end
