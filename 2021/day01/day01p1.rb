#2021 Levi D. Smith

strFile = ARGV[0]

f = File.open(strFile)

strValues = Array.new

iPrevious = -1
iIncreasedCount = 0

f.readlines().each do  | strLine | 
    iValue = strLine.chomp.to_i

    puts "value: " + iValue.to_s

    if (iPrevious >= 0)
        if (iValue > iPrevious)
            iIncreasedCount += 1
        end
    end

    iPrevious = iValue

end

f.close()

puts "Increased Count: " + iIncreasedCount.to_s