#2021 Levi D. Smith

class Entry
    attr_accessor :strSignalPatterns
    attr_accessor :strOutputValues

    def initialize(in_strSignalPatterns, in_strOutputValues) 
        self.strSignalPatterns = in_strSignalPatterns
        self.strOutputValues = in_strOutputValues
    end

    def displayValues()
        for i in (0...strSignalPatterns.length)
            puts "Signal #{i}: #{strSignalPatterns[i]}"
        end

        for i in (0...strOutputValues.length)
            puts "Output #{i}: #{strSignalPatterns[i]}"
        end

    end

    def getValueCount(iInSegments)
        iCount = 0
        strOutputValues.each do | strValue |
            if (iInSegments.include?(strValue.length))
                iCount += 1
            end
        end

        return iCount

    end

end


strFile = ARGV[0]
entries = Array.new
strSignalPatterns = Array.new
strOutputValues = Array.new

f = File.open(strFile)

f.readlines().each do | strLine |
#    puts strLine

    strTokens = strLine.chomp.split("|")
    strSignalPatterns = strTokens[0].split(" ")
    strOutputValues = strTokens[1].split(" ")
    entry = Entry.new(strSignalPatterns, strOutputValues)
    entries << entry
end

f.close()


iTotalCount = 0
entries.each do | entry |
#    entry.displayValues()
#    puts "Count: #{entry.getValueCount([2, 4, 3, 7])}"
    iTotalCount += entry.getValueCount([2, 4, 3, 7])
end

puts "Total Count: #{iTotalCount}"