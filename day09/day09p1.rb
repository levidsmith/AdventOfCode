#2021 Levi D. Smith

class LavaTube
    
    @heightmap
    @iRows
    @iCols


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
#lavatube.findLowPoints()

puts "Risk Level: #{lavatube.getRiskLevel()}"
