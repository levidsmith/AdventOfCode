#2021 Levi D. Smith

strFile = ARGV[0]

f = File.open(strFile)

lines = Array.new

f.readlines().each do  | strLine | 
    lines << strLine.chomp

end

f.close()


iHorizontal = 0
iDepth = 0

lines.each do | line |
    strCommand = line.split(" ")[0]
    iUnits = line.split(" ")[1].to_i
#    puts "Command: #{strCommand} Units: #{iUnits}"

    if (strCommand == "forward")
        iHorizontal += iUnits
    elsif (strCommand == "down")
        iDepth += iUnits
    elsif (strCommand == "up")
        iDepth -= iUnits
    end


end

puts "Horizontal: #{iHorizontal} Depth: #{iDepth}"

iResult = iHorizontal * iDepth
puts "result: #{iResult}"