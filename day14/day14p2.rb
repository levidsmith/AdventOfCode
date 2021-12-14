#2021 Levi D. Smith

class Polymer

    def initialize()
        @rules = Array.new
        @allChars = Array.new
    end

    def setTemplate(strInTemplate)
        @strTemplate = strInTemplate

    end

    def addRule(inRule)
        @rules << inRule

        rule = inRule
        if (not @allChars.include?(rule[0].chars[0]))
            @allChars << rule[0].chars[0]
        end

        if (not @allChars.include?(rule[0].chars[1]))
            @allChars << rule[0].chars[1]
        end

        if (not @allChars.include?(rule[1]))
            @allChars << rule[1]
        end
    end


    def displayPolymer()
        puts "Template: #{@strTemplate}"
#        displayRules()
    end

    def displayRules()
        @rules.each do | rule |
            puts "Rule: #{rule[0]} => #{rule[1]}"
        end
    end

    def makeBuckets()

        @buckets = Hash.new
        @ruleMap = Hash.new
        @rules.each do | rule |
#            @buckets[rule[0]] = 0
            @ruleMap[rule[0]] = rule[1]
        end

        
        puts @ruleMap

        puts @buckets


        for i in 0...@strTemplate.length - 1
            newKey = @strTemplate[i, 2]
            if (@buckets[newKey].nil?)
                @buckets[newKey] = 1
            else
                @buckets[newKey] += 1
            end

        end

        puts @buckets
        hashCount()
        charCount()
        puts


#        iTimes = 10
        iTimes = 40
        (0...iTimes).each do | i |
            puts "Step #{i + 1}"
            step()
            puts
        end

 


        
    end

    def step()

        bucketsAdd = Hash.new
        @buckets.each do | k, v |
#            puts "key: #{k} value: #{v}"

            newKey1 = "#{k[0]}#{@ruleMap[k]}"
            newKey2 = "#{@ruleMap[k]}#{k[1]}"
#            puts "newKey1 #{newKey1}"
#            puts "newKey2 #{newKey2}"

            if (bucketsAdd[newKey1].nil?)
                bucketsAdd[newKey1] = v
            else
                bucketsAdd[newKey1] += v
            end

            if (bucketsAdd[newKey2].nil?)
                bucketsAdd[newKey2] = v
            else
                bucketsAdd[newKey2] += v
            end

        end

        @buckets = bucketsAdd
        
        puts @buckets
        hashCount()
        charCount()

    end

    def hashCount()
        iCount = 0
        @buckets.each do | k, v |
            iCount += v
        end

        puts "Count #{iCount + 1}"

    end

    def charCount()
        #allChars = ["N", "C", "B", "H"]



        charCountMap = Hash.new
        @buckets.each do | k, v |
            @allChars.each do | c |
#                if (k.chars.include?(c))
                if (k.chars[0] == c)
                    if (charCountMap[c].nil?)
                        charCountMap[c] = v
                    else
                        charCountMap[c] += v
                    end
                end
            end

#            if (k.chars.include?("B"))
#                if (charCountMap["B"].nil?)
#                    charCountMap["B"] = v
#                else
#                    charCountMap["B"] += v
#                end
#            end
        end

        c = @strTemplate.chars.last
        if (charCountMap[c].nil?)
            charCountMap[c] = 1
        else
            charCountMap[c] += 1
        end

        puts charCountMap
        createCountMap(charCountMap)




    end

end

def createCountMap(countMap)
    sortedMap =  countMap.sort_by { |k, v | v}
    puts "Least: #{sortedMap.first[1]}"
    puts "Most: #{sortedMap.last[1]}"
    puts "Difference: #{sortedMap.last[1] - sortedMap.first[1]}"


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
#polymer.stepTimes(10)
#polymer.createCountMap()
polymer.makeBuckets()
