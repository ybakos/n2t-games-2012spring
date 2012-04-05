f1 = File.new(ARGV[0], "r")
f2 = File.new("dec_for_zombie.txt", "w")
bin = ""
for i in f1
	i.chomp!
	bin += i
	f2.puts "#{i} #{i.to_i(2)} #{32767 - i.to_i(2)}"
end
f2.puts bin.to_i(2)
