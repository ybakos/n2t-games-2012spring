#! /usr/bin/env ruby

path = ARGV[0]
filepaths = []
if File.directory? path
	Dir["#{path}/*.lvl"].each {|file| filepaths.push(file)}
else
	filepaths.push(path)
end

filepaths.each do |filepath|
	chambername = File.basename(filepath, ".lvl")
	infile = File.new(filepath, "r")
	outfile = File.new(chambername + ".txt", "w")

	outfile.write("/** COPY THIS FUNCTION INTO Chambers.jack AND USE IT THERE */\n")
	outfile.write("function void build" + chambername + "(Array chamber) {\n")

	i = 0
	infile.each do |line|
		puts line
		line.split("").each do |char|
			if(char == 'M')
				outfile.write("\tlet chamber[#{i}] = 1;\n")
			end

			if(char == 'X')
				outfile.write("\tlet chamber[#{i}] = 2;\n")
			end
			
			if(char == 'E')
				outfile.write("\tlet chamber[#{i}] = 3;\n");
			end
			
			if(char != "\n")
				i += 1
			end
		end
	end
	outfile.write("\treturn;\n}\n")

	infile.close()
	outfile.close()
end
