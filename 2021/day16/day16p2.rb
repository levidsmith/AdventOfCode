#2021 Levi D. Smith

class Packet


    def initialize(str)
        @strHex = str
        @iSumOfVersion = 0

        @byteMap = Hash.new
        @byteMap['0'] = "0000"
        @byteMap['1'] = "0001"
        @byteMap['2'] = "0010"
        @byteMap['3'] = "0011"
        @byteMap['4'] = "0100"
        @byteMap['5'] = "0101"
        @byteMap['6'] = "0110"
        @byteMap['7'] = "0111"
        @byteMap['8'] = "1000"
        @byteMap['9'] = "1001"
        @byteMap['A'] = "1010"
        @byteMap['B'] = "1011"
        @byteMap['C'] = "1100"
        @byteMap['D'] = "1101"
        @byteMap['E'] = "1110"
        @byteMap['F'] = "1111"
    end

    def getBits()
        strBits = ""

        @strHex.chars.each do | c |
            strBits += @byteMap[c] 
        end

        return strBits

    end

    def parseBits()
        strBits = getBits()
        readPacket(strBits)

    end

        
    def readPacket(strBits)
        puts "Packet: #{strBits}"
        
        
        iPacketValue = 0
        subPacketValues = Array.new

        iBitsRead = 0

        packetVersion = strBits[0...3]
        iBitsRead += 3
        iVersion = binaryStringToDecimal(packetVersion)
        puts "  packetVersion: #{packetVersion} => #{iVersion}"
        @iSumOfVersion += iVersion


        typeID = strBits[3...6]
        iBitsRead += 3
        iTypeID = binaryStringToDecimal(typeID)
        print "  typeID: #{typeID} => #{iTypeID}"

        if (iTypeID == 4)
            puts " (literal)"
            literalValue = strBits[6...strBits.length]
#            puts "  binary String: #{literalValue}"
            
            binaryValue = literalToBinaryString(literalValue)
            puts "  binaryNumber: #{binaryValue[0]}"

            iPacketValue = binaryStringToDecimal(binaryValue[0])
            puts "  decimal: #{iPacketValue}"
            iBitsRead += binaryValue[1]
        else
            puts " (operator)"
            lengthTypeID = strBits[6]
            iBitsRead += 1
            
            lengthTypeMap = Hash.new
            lengthTypeMap[0] = 15
            lengthTypeMap[1] = 11

            print "  lengthType: #{lengthTypeID}"

            if (lengthTypeID.to_i == 0)
                puts " (bit length)"
                totalLengthInBits = strBits[7...7 + 15]
                iTotalLength = binaryStringToDecimal(totalLengthInBits)
                iBitsRead += 15

                puts "  totalLengthInBits: #{totalLengthInBits} => #{iTotalLength}"
                
                i = 7 + 15
                while (i < 7 + 15 + iTotalLength)
                    #iPacketSize = readPacket(strBits[i...i + iTotalLength])
                    subPacket = readPacket(strBits[i...i + iTotalLength])
                    subPacketValues << subPacket[0]
                    iPacketSize = subPacket[1]
                    i += iPacketSize
                    iBitsRead += iPacketSize     
                end
                
            
            elsif (lengthTypeID.to_i == 1)
                puts " (packet number)"
                numOfSubPackets = strBits[7...7 + 11]
                iSubPackets = binaryStringToDecimal(numOfSubPackets)
                puts "  numOfSubPackets: #{numOfSubPackets} => #{iSubPackets}"
                iBitsRead += 11

                i = 7 + 11
                iPacketsRead = 0
                while (iPacketsRead < iSubPackets)
                    #iPacketSize = readPacket(strBits[i...strBits.length])
                    subPacket = readPacket(strBits[i...strBits.length])
                    subPacketValues << subPacket[0]
                    iPacketSize = subPacket[1]
                    i += iPacketSize
                    iBitsRead += iPacketSize
                    iPacketsRead += 1
                end
                
            end


        end

#        puts "  bits read: #{iBitsRead}"

        puts "  typeID: #{iTypeID}"
        puts "  subPackets: #{subPacketValues}"
        case iTypeID
        when 0 
            iPacketValue = subPacketValues.sum
        when 1
            iPacketValue = subPacketValues[0]
            for i in (1...subPacketValues.length)
                iPacketValue *= subPacketValues[i]
            end
        when 2
            iPacketValue = subPacketValues.min
        when 3
            iPacketValue = subPacketValues.max
        when 5
            if (subPacketValues[0] > subPacketValues[1])
                iPacketValue = 1
            else 
                iPacketValue = 0
            end
        when 6
            if (subPacketValues[0] < subPacketValues[1])
                iPacketValue = 1
            else 
                iPacketValue = 0
            end
        when 7
            if (subPacketValues[0] == subPacketValues[1])
                iPacketValue = 1
            else 
                iPacketValue = 0
            end


        end

        puts "  packetValue: #{iPacketValue}"
        puts "EndPacket"


        value = Array.new
        value << iPacketValue
        value << iBitsRead
        return value

    end

    def binaryStringToDecimal(strBinary)
        iValue = 0
        (strBinary.chars.length - 1).downto(0) { | i | 
#            puts strBinary.chars[i]
            iBit = strBinary.chars[i].to_i
            if (iBit == 1)
                iValue += 2 ** (strBinary.chars.length - 1 - i)
            end
        }
            
        return iValue
    end

    def literalToBinaryString(strLiteral)
        iBitsRead = 0
        i = 0
        strValue = ""
        keepLooping = true
        while (keepLooping && i < strLiteral.length)
            #print "Group #{strLiteral.chars[i + 0]} #{strLiteral.chars[i + 1..i + 4]}"

            if (strLiteral[i + 0].to_i == 0)
                keepLooping = false
            end
            strValue += strLiteral[i + 1..i + 4]
            iBitsRead += 5

            i += 5
        end

        #return the value read and the number of bits read
        value = Array.new
        value << strValue
        value << iBitsRead
        return value
           
    end

end


strFile = ARGV[0]

f = File.open(ARGV[0])

f.readlines().each do | strLine |
    puts strLine.chomp

    packet = Packet.new(strLine.chomp)
    
    packet.parseBits()
    puts "====================="
    puts ""

end

f.close()