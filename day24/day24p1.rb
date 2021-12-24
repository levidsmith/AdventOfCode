#2021 Levi D. Smith
class ALU

    def initialize()
        @registers = Hash.new
        @registers["w"] = 0
        @registers["x"] = 0
        @registers["y"] = 0
        @registers["z"] = 0


    end

    def setInputStream(strInputStream)
        @opCount = 0
        @registers["w"] = 0
        @registers["x"] = 0
        @registers["y"] = 0
        @registers["z"] = 0
        @inputStream = strInputStream.chars.collect { | c | c.to_i}.reverse
    end

    def processLine(strLine)
#        puts "processLine #{strLine}"
        @opCount += 1
#        print "Op #{@opCount}: "
        strTokens = strLine.split(" ")
        strOp = strTokens[0]

#        puts "op: #{strOp}"
        case strOp
        when "inp"
            opInput(strTokens[1])
        when "add"
            opAdd(strTokens[1], strTokens[2])
        when "mul"
            opMultiply(strTokens[1], strTokens[2])
        when "eql"
            opEquals(strTokens[1], strTokens[2])
        when "div"
            opDivide(strTokens[1], strTokens[2])
        when "mod"
            opModulo(strTokens[1], strTokens[2])
            
        end


    end

    def opInput(strRegister)
#        puts "input"
        iInput = @inputStream.pop
#        puts "Storing #{iInput} in register #{strRegister}"
        @registers[strRegister] = iInput

    end

    def opAdd(strRegister, strValue)
        
        if (@registers.keys.include?(strValue))
#            puts "add #{strValue} (#{@registers[strValue]}) to #{strRegister} (#{@registers[strRegister]})"
            @registers[strRegister] += @registers[strValue]
        else
#            puts "add #{strValue.to_i} to #{strRegister} (#{@registers[strRegister]})"
            @registers[strRegister] += strValue.to_i
        end

    end


    def opMultiply(strRegister, strValue)
        if (@registers.keys.include?(strValue))
#            puts "multiply #{strRegister} (#{@registers[strRegister]}) by #{strValue} (#{@registers[strValue]})"
            @registers[strRegister] *= @registers[strValue]
        else
#            puts "multiply #{strRegister} (#{@registers[strRegister]}) by #{strValue.to_i}"
            @registers[strRegister] *= strValue.to_i
        end

    end

    def opEquals(strRegister, strValue)
#        puts "equals #{strRegister}, #{strValue}"

        if (@registers.keys.include?(strValue))
            iValue = @registers[strValue].to_i
        else
            iValue = strValue.to_i
        end


        if (@registers[strRegister] == iValue)
            @registers[strRegister] = 1

        else
            @registers[strRegister] = 0

        end
    end


    def opDivide(strRegister, strValue)
#        puts "divide #{strRegister}, #{strValue}"

        if (@registers.keys.include?(strValue))
#            puts "divide #{strRegister} (#{@registers[strRegister]}) by #{strValue} (#{@registers[strValue]})"
            iValue = @registers[strValue].to_i
        else
#            puts "divide #{strRegister} (#{@registers[strRegister]}) by #{strValue.to_i}"
            iValue = strValue.to_i
        end


        iValue = (@registers[strRegister] / iValue).floor
        @registers[strRegister] = iValue

    end

    def opModulo(strRegister, strValue)

        if (@registers.keys.include?(strValue))
#            puts "modulo #{strRegister} (#{@registers[strRegister]}) by #{strValue} (#{@registers[strValue]})"
            iValue = @registers[strValue].to_i
        else
#            puts "modulo #{strRegister} (#{@registers[strRegister]}) by #{strValue.to_i}"
            iValue = strValue.to_i
        end

        iValue = (@registers[strRegister] % iValue).floor
        @registers[strRegister] = iValue

    end


    def to_s
        str = "Registers:\n"
        @registers.each do | k, v |
            str += " #{k}: #{v}\n"
        end

        return str

    end

    def isModelNumberValid()
        isValid = false
        if (@registers["z"] == 0)
            isValid = true
        end
        return isValid
    end

end



strFile = ARGV[0]

strInputs = Array.new
f = File.open(strFile)

f.readlines().each do  | strLine | 
    strInput = strLine.chomp
    if ((not strInput == "") && (not strInput.start_with?("#")))
        strInputs << strInput
    end
end


alu = ALU.new()


#iModelNumber = 99999999999999 #takes too long
#iModelNumber = 49999999999999 #valid
# iModelNumber = 51000000000000 #takes too long
# iModelNumber = 50000000032500 #slow
 iModelNumber = 50000000032500 #slow
keepLooping = true
while (keepLooping)
    strModelNumber = "#{iModelNumber}"
    puts "Model Number: #{strModelNumber}"
    alu.setInputStream(strModelNumber)
    strInputs.each do | strInput|
        alu.processLine(strInput)
#        puts alu
    end

    if (alu.isModelNumberValid())
        puts "#{strModelNumber} is valid"
        keepLooping = false
    else
        iModelNumber -= 1

        if (iModelNumber < 0)
            puts "No valid model numbers"
            keepLooping = false

        end
    end

end
