require 'rubygems'
require File.expand_path '../lib/websocket_client', File.dirname(__FILE__)

url = ARGV.shift || 'ws://localhost:9000'
client = WebSocketClient.new url

client.on :data do |data|
  puts data
end

loop do
  client.send STDIN.gets.strip
end
