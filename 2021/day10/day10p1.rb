#2021 Levi D. Smith
strFile = ARGV[0]

class SubsystemLine 

    @strLine = ""
    @@closingCharMap
    @@pointsMap

    def initialize(strInput)
#        puts "New SubsystemLine: #{strInput}"
        @strLine = strInput
        
        @@closingCharMap = Hash.new
        @@closingCharMap["("] = ")"
        @@closingCharMap["["] = "]"
        @@closingCharMap["{"] = "}"
        @@closingCharMap["<"] = ">"

        @@pointsMap = Hash.new
        @@pointsMap[")"] = 3
        @@pointsMap["]"] = 57
        @@pointsMap["}"] = 1197
        @@pointsMap[">"] = 25137
    end

    def parseLine()
#        puts "parsing line: #{@strLine}"

        iPoints = 0

        stack = Array.new
        countCharMap = Hash.new
        countCharMap["("] = 0
        countCharMap["["] = 0
        countCharMap["{"] = 0
        countCharMap["<"] = 0

        keepLooping = true
        for i in (0...@strLine.length)
            if (keepLooping)
#                puts "stack: #{stack}"
                c = @strLine[i]
                if (@@closingCharMap.keys.include? c)
#                    puts "Pushing #{c} to stack"
                    stack << c
                elsif (i < 1 and @@closingCharMap.values.include? c)
#                    puts "Parse error at #{i}.  Input began with closing character"
                    iPoints = @@pointsMap[c]
                    keepLooping = false
                elsif (@@closingCharMap[stack.last] == c)
#                    puts "Found match #{c}.  Popping #{stack[i - 1]} from stack"
                    stack.pop()
                elsif (@@closingCharMap.values.include? c)
#                    puts "Parse error at #{i}."
                    puts "Expected #{@@closingCharMap[stack.last]} but found #{c} instead."
                    iPoints = @@pointsMap[c]
                    keepLooping = false
                end
            end
        end

        return iPoints

    end
end


subsystemlines = Array.new
f = File.open(strFile)

f.readlines().each do | strLine |
#    puts strLine.chomp

    subsystemlines << SubsystemLine.new(strLine.chomp)
end

f.close()

#The corrupted lines
#[2,4,5,7,8].each do | i |
#    subsystemlines[i].parseLine()
#end

#All lines
iTotalPoints = 0
subsystemlines.each do | subsystemline |
    iTotalPoints += subsystemline.parseLine()
end

puts "Total points #{iTotalPoints}"

