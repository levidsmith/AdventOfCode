#2021 Levi D. Smith

class SnailfishNumber
    attr_accessor :elements
    attr_accessor :name

    @@id = 0

    def initialize()
        iTimes = (@@id / 26).floor
        @name = ((0..iTimes).collect { | iTime |  ('A'.ord + (@@id % 26)).chr }).join
        @@id += 1
        @elements = Array.new(2)
#        parse(strLine)
    end


    def parse(strValue)
#        puts "parsing #{strValue}"
        iOpenIndex = 0
        iCommaIndex = -1
        iCloseIndex = -1

        i = 1
        iBracketCount = 1
        while (i < strValue.length)
            if (strValue[i] == "[")
                iBracketCount += 1
            elsif (strValue[i] == ",")
                if (iBracketCount == 1)
                    iCommaIndex = i

                    strFirstElement = strValue[iOpenIndex + 1..iCommaIndex - 1]
                    if (isNumber(strFirstElement))
#                        puts "is a number"
                        @elements[0] = strFirstElement.to_i
                    else
                        snailfishnumber = SnailfishNumber.new()
                        snailfishnumber.parse(strFirstElement)
                        @elements[0] = snailfishnumber
                    end

                end
            elsif (strValue[i] == "]")
                iBracketCount -= 1

                if (iBracketCount == 0)
                    iCloseIndex = i

                    strSecondElement = strValue[iCommaIndex + 1..iCloseIndex - 1]
                    if (isNumber(strSecondElement))
#                        puts "is a number"
                        @elements[1] = strSecondElement.to_i
                    else
                        snailfishnumber = SnailfishNumber.new()
                        snailfishnumber.parse(strSecondElement)
                        @elements[1] = snailfishnumber
                    end

                end
            end
            i += 1
        end

#        puts "OpenBracket: #{iOpenIndex} Comma: #{iCommaIndex} CloseBracket: #{iCloseIndex}"


    end

    def isNumber(strValue)
        return strValue.match?(/^\d+$/)


    end

    def add(inSnailfishNumber)
        snailfishnumberResult = SnailfishNumber.new()
        snailfishnumberResult.elements[0] = self
        snailfishnumberResult.elements[1] = inSnailfishNumber


        return snailfishnumberResult
    end

    def to_s()
        str = "#{@name} pair: "

        if (@elements[0].instance_of?(SnailfishNumber))
            str += @elements[0].name
            puts @elements[0]
        else
            str += @elements[0].to_s
        end
        str += ", "
        if (@elements[1].instance_of?(SnailfishNumber))
            puts @elements[1]
            str += @elements[1].name
        else
            str += @elements[1].to_s
        end



        return str
    end

    def printSnailfishNumber()

        print "["
        if (elements[0].instance_of?(SnailfishNumber))
            print elements[0].printSnailfishNumber()
        else
            print elements[0]
        end
        print ","
        if (elements[1].instance_of?(SnailfishNumber))
            print elements[1].printSnailfishNumber()
        else
            print elements[1]
        end
        print "]"
    end

    def reduce(inDepth)
        puts "Reducing #{@name}, depth: #{inDepth}"

        if (inDepth == 4)
            puts "Explode #{@name}"
        end

        if (elements[0].instance_of?(SnailfishNumber))
            elements[0].reduce(inDepth + 1)
        end

        if (elements[1].instance_of?(SnailfishNumber))
            elements[1].reduce(inDepth + 1)
        end


    end


end


strFile = ARGV[0]


f = File.open(ARGV[0])

snailfishnumbers = Array.new

f.readlines().each do | strLine |
#    puts strLine.chomp
    strInput = strLine.chomp


    if (not strInput.start_with?("#"))
        puts strInput
        snailfishnumber = SnailfishNumber.new()
        snailfishnumber.parse(strLine.chomp)
#        puts "Pair: #{snailfishnumber.elements[0]}, #{snailfishnumber.elements[1]}"
        snailfishnumbers << snailfishnumber
        puts snailfishnumber
        puts "==================="
        puts

        snailfishnumber.reduce(0)
        snailfishnumber.printSnailfishNumber
    end


end



f.close()

#puts snailfishnumbers[0]
#puts snailfishnumbers[1]

#puts "Result: #{snailfishnumbers[0].add(snailfishnumbers[1])}"
#puts
#puts snailfishnumbers[0].add(snailfishnumbers[1]).printSnailfishNumber()

