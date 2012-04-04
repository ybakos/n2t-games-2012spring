#! /usr/bin/env ruby

path = ARGV[0]
filepaths = []
if File.directory? path
	Dir["#{path}/*.ppm"].each {|file| filepaths.push(file)}
else
	filepaths.push(path)
end

filepaths.each do |filepath|
	spritename = File.basename(filepath, ".ppm")
	infile = File.new(filepath, "r")

	verificationCode = infile.readline.chomp()
	if verificationCode != "P3"
		abort("not correct ppm format - missing P3 code")
	end

	outfile = File.new(spritename + ".txt", "w")

	outfile.write("/** COPY THIS INTO WHEREVER TILESETS OR SPRITES ARE USED */\n")

	infile.readline
	dimensions = infile.readline.scan(/\d+/)
	a = dimensions[1].to_i
	b = dimensions[0].to_i
	infile.readline

	address = 16384
	for x in 0...a do
		sum = 0
		for y in 0...b do
			sum = sum << 1
			temp = infile.readline.to_i
			temp += infile.readline.to_i
			temp += infile.readline.to_i
			if(temp == 0)
				if(y%16==0)
					sum=-1
				else
					sum += 1
				end
			end

			if(sum == -32768)
				sum += 1
			end

			if(y%16==15)
				if(sum!=-1)
					outfile.write("do Memory.poke(#{address+b/16-(y/16-1)-2} + offset, #{sum});\n")
				end
				sum = 0
			elsif(y==b-1)
				sum = sum << (b/16+1)*16-b
				puts sum
				if(sum!=-1)
					outfile.write("do Memory.poke(#{address+b/16-(y/16-1)-2} + offset, #{sum});\n")
				end
				sum = 0
			end
		end
		address += 32
	end

	infile.close()
	outfile.close()
end
