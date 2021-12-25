#2021 Levi D. Smith

class LavaTube
    
    @heightmap
    @checkedHeightmap
    @iRows
    @iCols

    @basinSizes


    def initialize()
        @heightmap = Array.new
        @heightmap
        @iRows = 0
        @iCols = 0


    end

    def addRow(strLine)
        @iCols = strLine.length
        @iRows = @iRows + 1

        row = Array.new
        strLine.each_char { | c |
            row << c.to_i
        }

        @heightmap << row
    end

    def displayHeightMap() 
        for i in 0...@iRows
            for j in 0...@iCols
                print "#{@heightmap[i][j]},"
            end
            puts
        end
    end

    def findLowPoints()
        @basinSizes = Array.new

        lowpoints = Array.new

        for i in 0...@iRows
            for j in 0...@iCols
                isLowPoint = true
                if (i > 0)
                    if (@heightmap[i][j] >= @heightmap[i - 1][j])
                        isLowPoint = false
                    end
                end

                if (i < @iRows - 1)
                    if (@heightmap[i][j] >= @heightmap[i + 1][j])
                        isLowPoint = false
                    end
                end

                if (j > 0)
                    if (@heightmap[i][j] >= @heightmap[i][j - 1])
                        isLowPoint = false
                    end

                end

                if (j < @iCols - 1)
                    if (@heightmap[i][j] >= @heightmap[i][j + 1])
                        isLowPoint = false
                    end
                end

                if (isLowPoint)
                    lowpoints << @heightmap[i][j]

                end


                #print "#{@heightmap[i][j]},"
            end
            #puts
        end

        puts "Low points #{lowpoints}"


        return lowpoints

    end

    def getRiskLevel()
        iRisk = 0
        findLowPoints().each do | iValue |
            iRisk += iValue + 1
        end

        return iRisk
    end


    def getLargeBasins()
        @basinSizes = Array.new

        lowpoints = Array.new

        for i in 0...@iRows
            for j in 0...@iCols
                isLowPoint = true
                if (i > 0)
                    if (@heightmap[i][j] >= @heightmap[i - 1][j])
                        isLowPoint = false
                    end
                end

                if (i < @iRows - 1)
                    if (@heightmap[i][j] >= @heightmap[i + 1][j])
                        isLowPoint = false
                    end
                end

                if (j > 0)
                    if (@heightmap[i][j] >= @heightmap[i][j - 1])
                        isLowPoint = false
                    end

                end

                if (j < @iCols - 1)
                    if (@heightmap[i][j] >= @heightmap[i][j + 1])
                        isLowPoint = false
                    end
                end

                if (isLowPoint)
#                    lowpoints << @heightmap[i][j]

                    resetCheckedMap()
                    getBasinSize(i, j)
                    @basinSizes << @iBasinSize
                end


            end
        end

        @basinSizes.sort!

        iResult = -1
        puts "Three largest basins:"
        for i in @basinSizes.length - 3...@basinSizes.length - 0
            puts @basinSizes[i]
            if (iResult < 0) 
                iResult = @basinSizes[i]
            else
                iResult *= @basinSizes[i]
            end
        end

        #puts "Result: #{iResult}"
        return iResult
    end


    def resetCheckedMap()
        @checkedHeightmap = Array.new
        for i in 0...@iRows
            row = Array.new
            for j in 0...@iCols
                row << false
            end
            @checkedHeightmap << row
        end

        @iBasinSize = 0

    end

    def getBasinSize(i, j)
        if (@heightmap[i][j] < 9 and not @checkedHeightmap[i][j])
            @checkedHeightmap[i][j] = true
            @iBasinSize += 1
            if (i > 0)
                getBasinSize(i - 1, j)
            end

            if (i < @iRows - 1)
                getBasinSize(i + 1, j)
            end

            if (j > 0)
                getBasinSize(i, j - 1)

            end

            if (j < @iCols - 1)
                getBasinSize(i, j + 1)
            end
        end

    end


    
end

strFile = ARGV[0]

lavatube = LavaTube.new

f = File.open(strFile)

f.readlines().each do | strLine |
    puts strLine.chomp
    lavatube.addRow(strLine.chomp)
end

f.close()

lavatube.displayHeightMap()

puts "Three Largest Basins Result: #{lavatube.getLargeBasins()}"

#lavatube.resetCheckedMap()
#lavatube.getBasinSize(0, 1)
#puts "Basin size: #{lavatube.iBasinSize}"
