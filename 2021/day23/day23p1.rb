#2021 Levi D. Smith

class Room
    ROWS = 5
    COLS = 13

    def initialize()
        @room = Array.new(ROWS) { Array.new(COLS) { nil }}
        @iCurrentRow = 0
        @iTotalEnergyUsed = 0
    end

    def addRow(inRow)
        @iCurrentCol = 0
        inRow.each do | c |
            case c
            when "#"
                @room[@iCurrentRow][@iCurrentCol] = Wall.new()
            when "A", "B", "C", "D"
                @room[@iCurrentRow][@iCurrentCol] = Amphipod.new(c)
            end
            @iCurrentCol += 1
        end
        @iCurrentRow += 1
    end

    def move(inRow, inCol, inRowChange, inColChange)
        if (@room[inRow][inCol].instance_of?(Amphipod))
#            puts "Found Amphipod: #{@room[inRow][inCol]}"
            if (@room[inRow + inRowChange][inCol + inColChange].nil?)
#                puts "moving it"
                @room[inRow + inRowChange][inCol + inColChange] = @room[inRow][inCol]
                @room[inRow][inCol] = nil
                @iTotalEnergyUsed += @room[inRow + inRowChange][inCol + inColChange].iEnergyCost
            end
        end


    end

    def to_s
        str = ""
        for i in 0...ROWS do
            for j in 0...COLS do
                if (not @room[i][j].nil?)
                    str += @room[i][j].to_s
                else 
                    str += "."
                end

            end
            str += "\n"
        end

        str += "Total energy used: #{@iTotalEnergyUsed}"

        return str
    end
end

class Amphipod
    attr_accessor :iEnergyCost

    def initialize(inType)
        @strType = inType
        case inType
        when "A"
            @iEnergyCost = 1
        when "B"
            @iEnergyCost = 10
        when "C"
            @iEnergyCost = 100
        when "D"
            @iEnergyCost = 1000
        end
    end

    def to_s
        return @strType
    end
end

class Wall
    def initialize()

    end

    def to_s
        return "#"
    end
end


strFile = ARGV[0]


room = Room.new()

f = File.open(strFile)

f.readlines().each do  | strLine | 
    strInput = strLine.chomp
    if (not strInput.strip == "")
	    puts strInput
        room.addRow(strInput.chars)
    end
end

puts room
puts

room.move(2, 3, -1, 0)
puts room

room.move(1, 3, 0, -1)
puts room
puts

room.move(3, 3, -1, 0)
puts room
puts

room.move(2, 7, -1, 0)
puts room
puts

room.move(2, 9, -1, 0)
puts room
puts

room.move(1, 9, 0, -1)
puts room
puts

room.move(1, 8, 0, -1)
puts room
puts

room.move(1, 8, 0, 1)
puts room
puts
