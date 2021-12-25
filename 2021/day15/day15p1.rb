#2021 Levi D. Smith

class Cavern


    def initialize()
#        @gridMap = Hash.new
        @gridMap = Array.new
        @iRows = 0
        @iCols = 0
    end

    def addRow(strLine)
        
        row = strLine.chars.collect { | x | x.to_i }
        if (@iCols < row.length )
            @iCols = row.length
        end

        (0...@iCols).each do | i |
            @gridMap[(@iRows * @iCols) + i] = row[i]
        end

        @iRows += 1


    end


    def findPathDijkstras()

        @gridMap[0] = 0
#        puts @gridMap

        if (@distances.nil?)
            @distances = Array.new(@iRows * @iCols) { Float::INFINITY }
        end
        @distances[0] = 0

        queue = Array.new
        (0...@iRows * @iCols).each do | iValue |
            queue << iValue
        end

        while (queue.length > 0)
            
            iMinIndex = -1
            queue.each do | iValue |
                if (iMinIndex == -1)
                    iMinIndex = iValue
                else
                    if (@distances[iValue] < @distances[iMinIndex])
                        iMinIndex = iValue
                    end
                end
            end
#            puts "Min is #{iMinIndex}"
            queue.delete(iMinIndex)


            cell = getIndexCell(iMinIndex)
            i = cell[0]
            j = cell[1]
    
            adjacent = [[i, j - 1], [i, j + 1], [i - 1, j], [i + 1, j]]
            adjCells = Array.new
            adjacent.each do | adj |
                iCellAdj = getCellIndex(adj[0], adj[1])
                if (not iCellAdj.nil?)
                    adjCells << iCellAdj
                end
            end

#            puts adjCells

            adjCells.each do | iAdjCell |
                iAlt = @distances[iMinIndex] + @gridMap[iAdjCell]
#                puts "iAlt: #{iAlt}"
                if (iAlt < @distances[iAdjCell])
                    @distances[iAdjCell] = iAlt
                end

            end


    
        
        
        end

        puts "Total distance #{@distances[getCellIndex(@iRows - 1, @iCols - 1)]}"



    end


    def getCellIndex(i, j)
        iIndex = nil
        if (i >= 0 and i < @iRows and j >= 0 and j < @iCols)
            iIndex = (i * @iCols) + j
        end
        
        return iIndex
    end

    def getIndexCell(i)
            cell = Array.new(2)
            cell[0] = (i / @iCols).floor
            cell[1] = i % @iCols
        return cell
    end


    def getLowestRisk()
        puts "riskTotals: #{@riskTotals}"
        puts "Lowest: #{@riskTotals.min}"
    end

end


strFile = ARGV[0]

f = File.open(ARGV[0])

cavern = Cavern.new
f.readlines().each do | strLine |
    puts strLine.chomp
    cavern.addRow(strLine.chomp)
end

f.close()

cavern.findPathDijkstras()