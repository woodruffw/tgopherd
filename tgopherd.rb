require 'socket'
require 'eventmachine'

require_relative 'gopher_server'

if !ARGV[0] || !ARGV[1]
	abort("Usage: ruby #{__FILE__} <directory to serve> <port>")
else
	path = File.expand_path(ARGV[0])
	if !File.exist?(path)
		abort("Could not canonicalize #{path}. Check to make sure it exists.")
	else
		$ROOT = path
	end

	$PORT = ARGV[1].to_i
end

$HOSTNAME = Socket.gethostname

EventMachine.run do
	EventMachine.start_server '127.0.0.1', $PORT, GopherServer
end

