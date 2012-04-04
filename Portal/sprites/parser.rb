#! /usr/bin/env ruby

path = ARGV[0]
filepaths = []
if File.directory? path
	Dir["#{path}/*.img"].each {|file| filepaths.push(file)}
else
	filepaths.push(path)
end

filepaths.each do |filepath|
	spritename = File.basename(filepath, ".img")
	infile = File.new(filepath, "r")
	outfile = File.new(spritename + ".txt", "w")

	outfile.write("/** COPY THIS INTO WHEREVER TILESETS OR SPRITES ARE USED */\n")

	i = 15
	sum = 0
	address = 16384
	infile.each do |line|
		puts line
		line.split("").each do |char|
			if(char != ' ' && char != "\n")
				if(i == 15)
					sum -= 2**i
				else
					sum += 2**i
				end
			end

			if(char != "\n")
				i -= 1
			end
		end
		outfile.write("do Memory.poke(#{address} + offset, #{sum});\n")
		i = 15
		address += 32
		sum = 0
	end

	infile.close()
	outfile.close()
end
