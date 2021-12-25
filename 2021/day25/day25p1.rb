#2021 Levi D. Smith

class Room
    attr_accessor :hasMoved
    attr_accessor :iStep

    def initialize()
        @data = Array.new
        @iRows = 0
        @iStep = 0
    end

    def addRow(strLine)
        @data << strLine.chars
        @iRows += 1
        @iCols = strLine.chars.length

    end

    def step()
        @hasMoved = false
        @iStep += 1
        tempData = Array.new(@iRows) { Array.new(@iCols) }

        arrayCopy(@data, tempData)

        for i in 0...@iRows
            for j in 0...@iCols
                if (@data[i][j] == ">")

                    if (@data[i][(j + 1) % @iCols] == ".")
                        tempData[i][j] = "."
                        tempData[i][(j + 1) % @iCols] = ">"
                        @hasMoved = true
                    end
                end
            end
        end

        arrayCopy(tempData, @data)

        for i in 0...@iRows
            for j in 0...@iCols
                if (@data[i][j] == "v")

                    if (@data[(i + 1) % @iRows][j] == ".")
                        tempData[i][j] = "."
                        tempData[(i + 1) % @iRows][j] = "v"
                        @hasMoved = true
                    end
                end
            end
        end

        arrayCopy(tempData, @data)


    end

    def arrayCopy(arr1, arr2)
        for i in 0...@iRows
            for j in 0...@iCols
                arr2[i][j] = arr1[i][j]
            end
        end
        
    end

    def to_s
        str = ""
        for i in 0...@iRows
            for j in 0...@iCols
                str += @data[i][j]
            end
            str += "\n"
        end

        return str

    end

end

strFile = ARGV[0]


room = Room.new
f = File.open(strFile)

f.readlines().each do  | strLine | 
    strInput = strLine.chomp
    room.addRow(strInput)
#	puts strInput
end

puts room
puts "\n================\n"

iSteps = 1000
(0...iSteps).each do
    room.step

    #puts "#{room.iStep}: hasMoved: #{room.hasMoved}"
    if (not room.hasMoved)
        puts "Stopped moving at step #{room.iStep}"
        break
    end
end

puts room
puts

