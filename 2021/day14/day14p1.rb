#2021 Levi D. Smith

class Polymer

    def initialize()
        @rules = Array.new
    end

    def setTemplate(strInTemplate)
        @strTemplate = strInTemplate

    end

    def addRule(inRule)
        @rules << inRule
    end


    def displayPolymer()
        puts "Template: #{@strTemplate}"
#        displayRules()
    end

    def displayRules()
        @rules.each do | rule |
            puts "Rule: find: #{rule[0]} insert: #{rule[1]}"
        end
    end

    def stepTimes(iTimesCount)

        for iTimes in 0...iTimesCount

            strNewString = ""
            templateChars = @strTemplate.chars
            for i in 0...templateChars.length - 1
                strNewString += @strTemplate[i]
                @rules.each do | rule |
                    if (rule[0] == @strTemplate[i, 2])
#                    puts "Found: #{rule[0]}"
                        strNewString += rule[1]
                    end
                end
            end
            strNewString += @strTemplate[templateChars.length - 1]

#            puts "After step #{iTimes + 1}: #{strNewString}"
#            puts "Length #{strNewString.length}"
            @strTemplate = strNewString
        end
    end

    def createCountMap()
        countMap = Hash[@strTemplate.chars.group_by { |c| c}.map { |k, v| [k,v.count]}]
        puts countMap

        sortedMap =  countMap.sort_by { |k, v | v}
        puts "Least: #{sortedMap.first[1]}"
        puts "Most: #{sortedMap.last[1]}"
        puts "Difference: #{sortedMap.last[1] - sortedMap.first[1]}"

    end


end


strFile = ARGV[0]

f = File.open(ARGV[0])

polymer = Polymer.new
isFirstLine = true

f.readlines().each do | strLine |
#    puts strLine.chomp

    if (isFirstLine)
        polymer.setTemplate(strLine.chomp)
        isFirstLine = false
    elsif (not strLine.chomp == "")
        polymer.addRule(strLine.chomp.split(" -> "))
    end


end

f.close()

polymer.displayPolymer()
polymer.stepTimes(10)
polymer.createCountMap()
