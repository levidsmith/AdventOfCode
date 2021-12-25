#2021 Levi D. Smith
strFile = ARGV[0]

class SubsystemLine 

    @strLine = ""
    @@closingCharMap
    @@pointsMap

    SCORE_MULTIPLIER = 5

    def initialize(strInput)
#        puts "New SubsystemLine: #{strInput}"
        @strLine = strInput
        
        @@closingCharMap = Hash.new
        @@closingCharMap["("] = ")"
        @@closingCharMap["["] = "]"
        @@closingCharMap["{"] = "}"
        @@closingCharMap["<"] = ">"

        @@pointsMap = Hash.new
        @@pointsMap[")"] = 1
        @@pointsMap["]"] = 2
        @@pointsMap["}"] = 3
        @@pointsMap[">"] = 4
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

        isValid = true
        for i in (0...@strLine.length)
            if (isValid)
#                puts "stack: #{stack}"
                c = @strLine[i]
                if (@@closingCharMap.keys.include? c)
#                    puts "Pushing #{c} to stack"
                    stack << c
                elsif (i < 1 and @@closingCharMap.values.include? c)
#                    puts "Parse error at #{i}.  Input began with closing character"
#                    iPoints = @@pointsMap[c]
                    isValid = false
                elsif (@@closingCharMap[stack.last] == c)
#                    puts "Found match #{c}.  Popping #{stack[i - 1]} from stack"
                    stack.pop()
                elsif (@@closingCharMap.values.include? c)
#                    puts "Parse error at #{i}."
#                    puts "Expected #{@@closingCharMap[stack.last]} but found #{c} instead."
#                    iPoints = @@pointsMap[c]
                    isValid = false
                end
            end
        end

        if (isValid)
#            puts "stack: #{stack}"
            while (stack.length > 0)

                c = stack.pop
                cClosingChar = @@closingCharMap[c]
#                puts "c: #{c} cClosingChar: #{cClosingChar}"

                
                iPoints = (iPoints * SCORE_MULTIPLIER) + @@pointsMap[cClosingChar]
#                puts "points: #{iPoints}"


            end
        else
            iPoints = -1
        
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
pointsArray = Array.new
subsystemlines.each do | subsystemline |
    iPoints = subsystemline.parseLine()
    if (iPoints >= 0)
        puts "Points: #{iPoints}"
        pointsArray << iPoints
    end
end

iMiddleScore = pointsArray.sort[pointsArray.length / 2]
puts "Middle Score: #{iMiddleScore}"

