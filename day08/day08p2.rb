#2021 Levi D. Smith

DEBUG = false

class Entry
    attr_accessor :strSignalPatterns
    attr_accessor :strOutputValues

    @segmentMap = Hash.new

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

    def getOutputValue()
        iOutputValue = 0

        i = 0
        strOutputValues.each do | strValue |
            iOutputValue += getPatternValue(strValue) * (10 ** (strOutputValues.length - 1 - i))
            i += 1
        end

        return iOutputValue
    end

    def getPatternValue(strValue)
        iValue = -1

        case strValue.length
        when 2
            iValue = 1
        when 3
            iValue = 7
        when 4
            iValue = 4
        when 5
            if (containsAll(["a", "c", "d", "e", "g"], strValue))
                iValue = 2
            elsif (containsAll(["a", "c", "d", "f", "g"], strValue))
                iValue = 3
            elsif (containsAll(["a", "b", "d", "f", "g"], strValue))
                iValue = 5
    
            end
        when 6
            if (containsAll(["a", "b", "d", "e", "f", "g"], strValue))
                iValue = 6
            elsif (containsAll(["a", "b", "c", "d", "f", "g"], strValue))
                iValue = 9
            elsif (containsAll(["a", "b", "c", "e", "f", "g"], strValue))
                iValue = 0
            end

        when 7
            iValue = 8
        end
        
        return iValue
    end

    def containsAll(chars, strValue)
        hasAll = true
        chars.each do | charValue |
            if  not (strValue.include? charValue)
                hasAll = false
            end
        end

        return hasAll
    end

    def createSegmentMap()
        @segmentMap = Hash.new
        ("a".ord.."g".ord).each do | iValue |
            cValue = iValue.chr
            appearanceCheck(cValue, 4, "e")
            appearanceCheck(cValue, 6, "b")
            appearanceCheck(cValue, 9, "f")

        end


        strSignalPatterns.each do | strPattern |
            case strPattern.length
            when 2
                patternCheck(strPattern, 2, 8, true, -1, false, "c")
            when 4
                patternCheck(strPattern, 4, 7, true, -1, false, "d")
                patternCheck(strPattern, 4, 7, false, -1, false, "g")
            when 7
                patternCheck(strPattern, 7, 8, true, 4, false, "a")
            end


        end

        if (DEBUG)
            puts "Map: "
            @segmentMap.each do | key, value |
                puts "#{key} = #{value}"
            end
        end


        for i in 0...self.strOutputValues.length
            for j in 0...self.strOutputValues[i].length
                cOld = self.strOutputValues[i][j]

                self.strOutputValues[i][j] = @segmentMap[cOld]
            end

        end
    end

    def appearanceCheck(cValue, iInAppearance, cMapChar)
        if (iInAppearance == getTotalAppearances(cValue))
            if (DEBUG)
                puts "map #{cValue} to #{cMapChar}"
            end
            @segmentMap[cValue] = cMapChar

        end

    end

    def patternCheck(strInPattern, iInLength, iInAppearance, isIncluded, iInLength2, isIncluded2, cMapChar)
        if (strInPattern.length == iInLength)
            ("a".ord.."g".ord).each do | iValue |
            
                cValue = iValue.chr
                iAppearances = getTotalAppearances(iValue.chr)
                    
                if (iAppearances == iInAppearance and ((strInPattern.include? cValue) == isIncluded ))
                    isMapValid = false

                    if (iInLength2 < 0)
                        isMapValid = true
                    else
                        strSignalPatterns.each do | strPattern |
                            if (strPattern.length == iInLength2)
                                if ((strPattern.include? cValue) == isIncluded2)
                                    isMapValid = true
                                    
                                end
                            end
                        end
                    end

                    if (isMapValid)
                        if (DEBUG)
                            puts "map #{cValue} to #{cMapChar}"
                        end
                        @segmentMap[cValue] = cMapChar

                    end
                end
            end
        end
                    
            

    end

    def getMappedPattern(strPattern)
        strMappedPattern = ""
        for i in 0...strPattern.length
            cOld = strPattern[i]
            strMappedPattern[i] = @segmentMap[cOld]
        end

        return strMappedPattern
    end

    def getTotalAppearances(strChar)
        iCount = 0
        strSignalPatterns.each do | strPattern |
            if (strPattern.include? strChar)
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

    strTokens = strLine.chomp.split("|")
    strSignalPatterns = strTokens[0].split(" ")
    strOutputValues = strTokens[1].split(" ")
    entry = Entry.new(strSignalPatterns, strOutputValues)
    entries << entry
end

f.close()


iTotalCount = 0
entries.each do | entry |
    entry.createSegmentMap()


    iTotalCount += entry.getOutputValue()
    puts "Entry value: #{entry.getOutputValue()}"
end

puts "Total Count: #{iTotalCount}"