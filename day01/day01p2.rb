#2021 Levi D. Smith

WINDOW_SIZE = 3
strFile = ARGV[0]

f = File.open(strFile)

iValues = Array.new

f.readlines().each do  | strLine | 
    iValues << strLine.chomp.to_i
end

f.close()



iPrevious = -1
iIncreasedCount = 0

i = 0
while (i < iValues.length)
    print iValues[i].to_s + ": "
    if (i + 2 < iValues.length)
        iSum = iValues[i] + iValues[i + 1] + iValues[i + 2] 
        puts iSum.to_s

        if (iPrevious >= 0)
            if (iSum > iPrevious)
                iIncreasedCount += 1
            end
        end

        iPrevious = iSum

    else
        puts
    end


    i += 1
end



puts "Increased Count: " + iIncreasedCount.to_s