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


MODEL_LENGTH = 14

def analyzeInput(strInputs)
    #method based on approach from https://github.com/dphilipson/advent-of-code-2021/blob/master/src/days/day24.rs
    strDiv = ""
    strCheck = ""
    strOffset = ""

    strOutput = ""
    stack = Array.new

    mapDependency = Hash.new
    mapDependencyOffset = Hash.new

    iGreatestModel = Array.new(MODEL_LENGTH) { nil }
    iLeastModel = Array.new(MODEL_LENGTH) { nil }


    iLine = 0
    puts "#{"div".rjust(10, " ")} #{"check".rjust(10, " ")} #{"offset".rjust(10, " ")}"
    strInputs.each do | strInput |
        if (iLine % 18 == 4)
            strDiv = strInput.split(" ")[2]
        elsif (iLine % 18 == 5)
            strCheck = strInput.split(" ")[2]
        elsif(iLine % 18 == 15)
            strOffset = strInput.split(" ")[2]
            puts "#{strDiv.rjust(10, " ")} #{strCheck.rjust(10, " ")} #{strOffset.rjust(10, " ")}"

            if (strCheck.to_i > 0)
                stack.push([(iLine / 18).floor, strOffset.to_i])
            else 
                pop_value = stack.pop
                iLHS = (iLine / 18).floor
                iRHS = pop_value[0]
                iRHSOffset = strCheck.to_i + pop_value[1]
                strOutput += "input[#{iLHS}] == input[#{iRHS}] + #{iRHSOffset }"

                mapDependency[iLHS] = iRHS
                mapDependencyOffset[iLHS] = iRHSOffset
                strOutput += "\n"
            end


        elsif(iLine % 18 == 0)
            strDiv = ""
            strCheck = ""
            strOffset = ""
                   
        end

        iLine += 1
    end

    puts strOutput

    #Figure out the greatest number
    for i in 0...MODEL_LENGTH do
            if (mapDependency.values.include?(i))
                
                iLHS = mapDependency.key(i)
                if (mapDependencyOffset[iLHS] < 0)
                    iValue = 9
                else
                    iValue = 9 - mapDependencyOffset[iLHS]
                end
                
                iGreatestModel[i] = iValue
                
                iGreatestModel[iLHS] = iGreatestModel[i] + mapDependencyOffset[iLHS]
            end
    end

    puts "Greatest: " + iGreatestModel.join
    

    #Figure out the least number (with no zeroes)
    for i in 0...MODEL_LENGTH do
        if (mapDependency.values.include?(i))
            
            iLHS = mapDependency.key(i)
            if (mapDependencyOffset[iLHS] > 0)
                iValue = 1
            else
                iValue = 1 - mapDependencyOffset[iLHS]
            end
            
            iLeastModel[i] = iValue
            iLeastModel[iLHS] = iLeastModel[i] + mapDependencyOffset[iLHS]
        end
    end

    puts "Least: " + iLeastModel.join

    return [iLeastModel.join.to_i, iGreatestModel.join.to_i]


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




#iModelNumber = 99298993199873
#iModelNumber = 73181221197111
#iModelNumber = analyzeInput(strInputs)[0]
iModelNumber = analyzeInput(strInputs)[1]


strModelNumber = "#{iModelNumber}"
alu.setInputStream(strModelNumber)

strInputs.each do | strInput|
    alu.processLine(strInput)
end
puts alu
puts "#{iModelNumber} isValid: #{alu.isModelNumberValid()}"