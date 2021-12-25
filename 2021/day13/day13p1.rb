#2021 Levi D. Smith

class Paper

    def initialize(inDots, inFolds)
        @iRows = 0
        @iCols = 0
        
        inDots.each do | dot |
            if (dot[0] + 1 > @iCols)
                @iCols = dot[0] + 1
            end

            if (dot[1] + 1 > @iRows)
                @iRows = dot[1] + 1
            end
        end

        @grid = Array.new(@iRows) {Array.new(@iCols) { "." }}

        inDots.each do | dot |
            @grid[dot[1]][dot[0]] = "#"
        end

        @folds = inFolds

#        fold1 = @folds[0]
#        fold(fold1[0], fold1[1])

#        fold2 = @folds[1]
#        fold(fold2[0], fold2[1])


    end

    def foldTimes(iTimes)
        for i in 0...iTimes
            fold = @folds[i]
            fold(fold[0], fold[1])
        end

    end

    def displayGrid()
        for i in 0...@iRows
            for j in 0...@iCols
                print "#{@grid[i][j]} "
            end
            puts
        end

        @folds.each do | fold |
            puts "fold #{fold[0]}, #{fold[1]}"
        end
    end

    def countDots()
        iDotCount = 0
        for i in 0...@iRows
            for j in 0...@iCols
                if (@grid[i][j] == "#")
                    iDotCount += 1
                end
            end
        end

        puts iDotCount
    end

    def fold(axis, iFoldIndex)
        if (axis == "y")
            iFoldedRows = (@iRows / 2).floor
            iFoldedCols = @iCols
            foldedGrid = Array.new(iFoldedRows) {Array.new(iFoldedCols) { "." }}
        
        
            iOffset = 0
            for i in 0...@iRows
                for j in 0...@iCols
                    if (i < iFoldIndex)
                        if (@grid[i][j] == "#")
#                            puts "Copying #{i}, #{j} to #{i},#{j}"
                            foldedGrid[i][j] = @grid[i][j]
                        end
                    else
                        if (@grid[i][j] == "#")
                            iNewIndex = iFoldIndex - (i - iFoldIndex)
#                            puts "Copying #{i}, #{j} to #{iNewIndex},#{j}"
                            foldedGrid[iNewIndex][j] = @grid[i][j]
                        end

                    end
                end
            end

        end

        if (axis == "x")
            iFoldedRows = @iRows
            iFoldedCols = (@iCols / 2).floor
            foldedGrid = Array.new(iFoldedRows) {Array.new(iFoldedCols) { "." }}
        
        
            iOffset = 0
            for i in 0...@iRows
                for j in 0...@iCols
                    if (j < iFoldIndex)
                        if (@grid[i][j] == "#")
                            foldedGrid[i][j] = @grid[i][j]
                        end
                    else
                        if (@grid[i][j] == "#")
                            iNewIndex = iFoldIndex - (j - iFoldIndex)
                            foldedGrid[i][iNewIndex] = @grid[i][j]
                        end

                    end
                end
            end

        end




        @iRows = iFoldedRows
        @iCols = iFoldedCols
        @grid = foldedGrid

#        displayGrid()


    end

end


strFile = ARGV[0]

f = File.open(ARGV[0])

dots = Array.new
folds = Array.new

FOLD_PREFIX = "fold along "

f.readlines().each do | strLine |
    puts strLine.chomp

    if (not strLine.chomp == "" and not strLine.start_with?(FOLD_PREFIX))
        dot = strLine.chomp.split(",").collect { | str | str.to_i}
        dots << dot
    end

    if (strLine.start_with?(FOLD_PREFIX))
        fold = strLine.chomp.delete_prefix(FOLD_PREFIX).split("=")
        fold[1] = fold[1].to_i
        folds << fold
    end


end

f.close()

paper = Paper.new(dots, folds)
#paper.displayGrid
#paper.countDots

#paper.foldTimes(1)
paper.foldTimes()

paper.displayGrid
#paper.countDots
