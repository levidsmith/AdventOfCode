#2021 Levi D. Smith

strFile = ARGV[0]

class Grid
    attr_accessor :iValues
    attr_accessor :iRows
    attr_accessor :iCols


    def displayGrid()
        i = 0
        j = 0
        while (i < self.iRows)
            while (j < self.iCols)
                print self.iValues[i][j].to_s + " "
                j += 1
            end
                puts ""
            i += 1
            j = 0
        end
    
    end

    def createGrid(in_lines)
        iMaxRow = -1
        iMaxCol = -1

        #find the number of rows and columns
        in_lines.each do |line|
            line.each do | point|
                if (point[0] > iMaxCol)
                    iMaxCol = point[0]
                end
    
                if (point[1] > iMaxRow)
                    iMaxRow = point[1]
                end
    
            end
    
        end
    
        puts "Max row: #{iMaxRow} Max col: #iMaxCol}"
        iMaxRow += 1
        iMaxCol += 1
    
        self.iValues = Array.new(iMaxRow){Array.new(iMaxCol)}
        self.iRows = iMaxRow
        self.iCols = iMaxCol
    

        #initialize the 2D array
        i = 0
        j = 0
        while (i < self.iRows)
            while (j < self.iCols)
                self.iValues[i][j] = 0
                j += 1
            end
            i += 1
            j = 0
        end
    
    end

    def loadValues(in_lines)
        in_lines.each do |line|
            point1 = line[0]
            point2 = line[1]




                iRowStep = 0
                iColStep = 0
                if (point1[0] < point2[0])
                    iColStep = 1
                elsif (point1[0] > point2[0])
                    iColStep = -1
                end

                if (point1[1] < point2[1])
                    iRowStep = 1
                elsif (point1[1] > point2[1])
                    iRowStep = -1
                end


                puts "start value: #{point1[0]}, #{point1[1]}"
                puts "end value: #{point2[0]}, #{point2[1]} "
                puts "row step: #{iRowStep}"
                puts "col step: #{iColStep}"

                j = point1[0]
                i = point1[1]

            while (i != point2[1] || j != point2[0])
                self.iValues[i][j] += 1
                i += iRowStep
                j += iColStep
            end
            self.iValues[i][j] += 1

    
        end

    end


    def countOverlap()
        iCount = 0

        i = 0
        j = 0
        while (i < self.iRows)
            while (j < self.iCols)
#                print self.iValues[i][j].to_s + " "
                if (self.iValues[i][j] > 1)
                    iCount += 1
                end
                j += 1
            end
            i += 1
            j = 0
        end
        return iCount


    end

end


f = File.open(strFile)

lines = Array.new

f.readlines().each do  | strLine | 
    puts strLine.chomp
    strPoints = strLine.chomp.split(" -> ")
    puts "point #{strPoints[0]} | #{strPoints[1]}"
    point1 = strPoints[0].split(",").collect { | iValue| iValue.to_i }
    point2 = strPoints[1].split(",").collect { | iValue| iValue.to_i }

    puts "point1: (#{point1[0]}, #{point1[1]}) point2: (#{point2[0]}, #{point2[1]})"
    line = Array.new
    line[0] = point1
    line[1] = point2

    lines << line

end

f.close()


grid = Grid.new
grid.createGrid(lines)
#grid.displayGrid

grid.loadValues(lines)
#grid.displayGrid

puts "Count: #{grid.countOverlap}"


