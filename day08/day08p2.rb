#2021 Levi D. Smith

DEBUG = false

class Entry
    attr_accessor :strSignalPatterns
    attr_accessor :strOutputValues

    @segmentMap = Hash.new

    def initialize(in_strSignalPatterns, in_strOutputValues) 
        self.strSignalPatterns = in_strSignalPatterns
        self.strOutputValues = in_strOutputValues

       # createSegmentMap()
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
#            puts "value: #{strValue}: #{getPatternValue(strValue)}"
            iOutputValue += getPatternValue(strValue) * (10 ** (strOutputValues.length - 1 - i))
            i += 1
        end

        return iOutputValue
    end

    def getPatternValue(strValue)
        iValue = -1
#        puts strValue

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
        #segment = Hash.new

=begin        
        segments = Array.new(10)

        segments[0] = [1, 1, 1, 0, 1, 1, 1]
        segments[1] = [0, 0, 1, 0, 0, 1, 0]
        segments[2] = [1, 0, 1, 1, 1, 0, 1]
        segments[3] = [1, 0, 1, 1, 0, 1, 1]
        segments[4] = [0, 1, 1, 1, 0, 1, 0]
        segments[5] = [1, 1, 0, 1, 0, 1, 1]
        segments[6] = [1, 1, 0, 1, 1, 1, 1]
        segments[7] = [1, 0, 1, 0, 0, 1, 0]
        segments[8] = [1, 1, 1, 1, 1, 1, 1]
        segments[9] = [1, 1, 1, 1, 0, 1, 1]
=end

        @segmentMap = Hash.new
        ("a".ord.."g".ord).each do | iValue |


            cValue = iValue.chr
            iAppearances = getTotalAppearances(iValue.chr)
#            puts "#{iValue}: #{iValue.chr}"
#            puts "#{iValue.chr} total: #{getTotalAppearances(iValue.chr)}"


            if (iAppearances == 4)
                if (DEBUG)
                    puts "mapped #{cValue} to e"
                end
                @segmentMap[cValue] = "e"
            elsif (iAppearances == 6)
                if (DEBUG)
                    puts "mapped #{cValue} to b"
                end
                @segmentMap[cValue] = "b"

            elsif (iAppearances == 9)
                if (DEBUG)
                    puts "mapped #{cValue} to f"
                end
                @segmentMap[cValue] = "f"
            end

        end


        strSignalPatterns.each do | strPattern |
            if (strPattern.length == 2)
#                puts "Pattern: #{strPattern}"
                ("a".ord.."g".ord).each do | iValue |

                    cValue = iValue.chr
                    iAppearances = getTotalAppearances(iValue.chr)
#                    puts "#{iValue.chr} total: #{getTotalAppearances(iValue.chr)}"
        
        
                    if (iAppearances == 8 and strPattern.include? cValue)
                        if (DEBUG)
                            puts "found c: app: #{iAppearances} in #{strPattern}"
                            puts "mapped #{cValue} to c"
                        end
                        @segmentMap[cValue] = "c"
                    end
                end
        
            end

            if (strPattern.length == 4)
 #               puts "Pattern: #{strPattern}"
                ("a".ord.."g".ord).each do | iValue |
                    

                    cValue = iValue.chr
                    iAppearances = getTotalAppearances(iValue.chr)
#                    puts "#{iValue.chr} total: #{getTotalAppearances(iValue.chr)}"
        
        
                    if (iAppearances == 7 and strPattern.include? cValue)
                        if (DEBUG)
                            puts "mapped #{cValue} to d"
                        end

                        @segmentMap[cValue] = "d"
                    end

                    if (iAppearances == 7 and not strPattern.include? cValue)
                        if (DEBUG)
                            puts "mapped #{cValue} to g"
                        end

                        @segmentMap[cValue] = "g"
                    end

                end
        
            end


            if (strPattern.length == 7)
#                puts "Pattern: #{strPattern}"
                ("a".ord.."g".ord).each do | iValue |

                    cValue = iValue.chr
                    iAppearances = getTotalAppearances(cValue)
#                    puts "#{iValue.chr} iAppearances: #{iAppearances}"
        
        
                    if (iAppearances == 8 and strPattern.include? cValue)
                        strSignalPatterns.each do | strPattern |
                            if (strPattern.length == 4)
                                if (not strPattern.include? cValue)
                                    if (DEBUG)
                                        puts "mapped #{cValue} to a"
                                    end
                                    @segmentMap[cValue] = "a"
                                    
                                end
                            end
                        end

                    end


                end
        
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
#                puts "changing #{cOld} to #{@segmentMap[cOld]}"
                

                self.strOutputValues[i][j] = @segmentMap[cOld]
            end

        end
    end

    def getMappedPattern(strPattern)
        #strMappedPattern = Array.new(strPattern.length)
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
#    puts "Original values"
#    entry.strSignalPatterns.each do | strPattern |
#        puts "value: #{strPattern}"
#    end

    entry.createSegmentMap()

#    puts "Mapped values"
#    entry.strSignalPatterns.each do | strPattern |
#        puts "value: #{entry.getMappedPattern(strPattern)}"
#    end


    #iTotalCount += entry.getValueCount([2, 4, 3, 7])
    iTotalCount += entry.getOutputValue()
    puts "Entry value: #{entry.getOutputValue()}"
end

puts "Total Count: #{iTotalCount}"