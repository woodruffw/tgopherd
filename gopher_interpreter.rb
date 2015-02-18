require 'filemagic'

class GopherInterpreter

	def self.interpret(data)
		path = File.join($ROOT, data)

		if File.directory?(path)
			serve_directory(path)
		elsif File.file?(path)
			serve_file(path)
		else
			".\r\n"
		end
	end

	def self.serve_directory(dir)
		listing = ''

		puts Dir.entries(dir).join(', ')

		Dir.foreach(dir) do |entry|
			abspath = File.join(dir, entry)
			if File.directory?(abspath)
				listing += "1"
			elsif FileMagic.new(FileMagic::MAGIC_MIME).file(abspath) =~ /^text\//
				listing += "0"
			elsif FileMagic.new(FileMagic::MAGIC_MIME).file(abspath) =~ /^image\//
				listing += "I"
			else
				listing += "9"
			end
			listing += "#{entry}\t/#{entry}\t#{$HOSTNAME}\t#{$PORT}\r\n"
		end
		listing += ".\r\n"
		return listing
	end

	def self.serve_file(file)
		f = File.open(file)
		contents = f.read
		f.close()
		return contents
	end
end
