#2021 Levi D. Smith
strFile = ARGV[0]

class Cave
    
    @energylevels
    @hasFlashed
    @iRows
    @iCols

    def initialize()
        @energylevels = Array.new
        @iRows = 0
        @iCols = 0
        @iFlashCount = 0
        
    end

    def addRow(strLine)
        @iCols = strLine.length
        @iRows += 1

        row = Array.new
        strLine.each_char do | c |
            row << c.to_i
        end

        @energylevels << row
    
    end

    def displayCave()
        for i in 0...@iRows
            for j in 0...@iCols
                print "#{@energylevels[i][j]} "
            end
            puts
        end
    end

    def doStep()

        puts "Rows: #{@iRows} Cols: #{@iCols}"

#        puts "Has flashed"
        @hasFlashed = Array.new(@iRows) { Array.new(@iCols) {false} }
#        puts "#{@hasFlashed}"
#        for i in 0...@iRows
#            for j in 0...@iCols
#                puts "#{@hasFlashed[i][j]} "
#            end
#        end




#        puts "Step"
#        displayCave()

#        puts "increaseAll"
        increaseAll()
#        displayCave()

        for i in 0...@iRows
            for j in 0...@iCols
                if (@energylevels[i][j] > 9 and not @hasFlashed[i][j])
#                    puts "doFlash #{i}, #{j}"
                    doFlash(i, j)
                end
            end
        end

        resetFlashed()

    end

    def increaseAll()
        for i in 0...@iRows
            for j in 0...@iCols
                @energylevels[i][j] += 1
            end
        end

    end

    def doFlash(iInRow, iInCol)

        i = iInRow
        j = iInCol

        if (@energylevels[i][j] > 9 and not @hasFlashed[i][j])
#            puts "Flash #{i}, #{j}"
            @hasFlashed[i][j] = true
            @iFlashCount += 1

            increaseAdjacent(i - 1, j - 1)
            increaseAdjacent(i, j - 1)
            increaseAdjacent(i + 1, j - 1)

            increaseAdjacent(i - 1, j)
            increaseAdjacent(i + 1, j)

            increaseAdjacent(i - 1, j + 1)
            increaseAdjacent(i, j + 1)
            increaseAdjacent(i + 1, j + 1)


            
        end

    end

    def increaseAdjacent(iInRow, iInCol)
        i = iInRow
        j = iInCol
        if (i >= 0 and i < @iRows and j >= 0 and j < @iCols )
            @energylevels[i][j] += 1

            if (@energylevels[i][j] > 9 and not @hasFlashed[i][j])
                doFlash(i, j)
            end
        end

    end

    def resetFlashed()
        #could either check the flashed array or energy level > 9
        for i in 0...@iRows
            for j in 0...@iCols
                if (@hasFlashed[i][j])
                    @energylevels[i][j] = 0
                end
            end
        end

    end

    def getFlashCount()
        return @iFlashCount
    end

    
end


cave = Cave.new

f = File.open(strFile)

f.readlines().each do | strLine |
    puts strLine.chomp

    cave.addRow(strLine.chomp)


end

f.close()

cave.displayCave()

puts

#iStepsToPerform = 10
iStepsToPerform = 100
iTotalFlashes = 0

for i in 0...iStepsToPerform
    cave.doStep()
    iTotalFlashes = cave.getFlashCount()
    cave.displayCave()
    
    puts 
    
end

puts "Total Flashes #{iTotalFlashes}"

