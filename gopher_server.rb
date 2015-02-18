require 'eventmachine'

require_relative 'gopher_interpreter'

class GopherServer < EventMachine::Connection
	def initialize(*args)
		super
	end

	def receive_data(data)
		response = GopherInterpreter.interpret(data.chomp)
		send_data response
		close_connection_after_writing
	end
end
