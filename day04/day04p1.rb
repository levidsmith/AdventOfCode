#2021 Levi D. Smith

BOARD_SIZE = 5
$iNumbersToDraw = Array.new

def printBoard(board)

    i = 0
    while (i < BOARD_SIZE)
        j = 0
        while (j < BOARD_SIZE)

            puts "#{i}, #{j}: #{board[i][j]}"
            j += 1
        end

        i += 1
        j = 0

    end

end

def isWinner(board, iDrawnNumbers)
    checkedBoard = Array.new(BOARD_SIZE){Array.new(BOARD_SIZE)}

    i = 0
    while (i < BOARD_SIZE)
        j = 0
        while (j < BOARD_SIZE)
            if (iDrawnNumbers.include?(board[i][j]))
                checkedBoard[i][j] = true
            else 
                checkedBoard[i][j] = false
            end

            j += 1
        end

        i += 1
        j = 0

    end

    isWinner = false
    i = 0
    while (i < BOARD_SIZE)
        #check rows
        if (checkedBoard[i][0] &&
            checkedBoard[i][1] &&
            checkedBoard[i][2] &&
            checkedBoard[i][3] &&
            checkedBoard[i][4])
            isWinner = true
        end

        #check cols
        if (checkedBoard[0][i] &&
            checkedBoard[1][i] &&
            checkedBoard[2][i] &&
            checkedBoard[3][i] &&
            checkedBoard[4][i])
            isWinner = true
        end
        i += 1
    end

#    printBoard(checkedBoard)
    return isWinner

end


def getScore(board, iDrawnNumbers)
    checkedBoard = Array.new(BOARD_SIZE){Array.new(BOARD_SIZE)}

    iScore = 0

    i = 0
    while (i < BOARD_SIZE)
        j = 0
        while (j < BOARD_SIZE)
            if (not iDrawnNumbers.include?(board[i][j]))
                
                iScore += board[i][j]
            end

            j += 1
        end

        i += 1
        j = 0

    end

    return iScore


end


strFile = ARGV[0]

f = File.open(strFile)

boards = Array.new
board = Array.new

isFirstLine = true
iBoardRow = 0

f.readlines().each do  | strLine | 
    #strLine.chomp.to_i
    

    if (isFirstLine)
        strNumbersDrawn = strLine.split(",")

        strNumbersDrawn.each do | strValue |
            $iNumbersToDraw << strValue.to_i
        end
        isFirstLine = false

    elsif (strLine.chomp == "")
        puts "New board"
        #board = Array.new(BOARD_SIZE){Array.new(BOARD_SIZE)}
        board = Array.new
        iBoardRow = 0
    else
        iBoardRowValues = strLine.chomp.split(" ")
        iBoardRowValues.collect! { | str | str.to_i }
        board << iBoardRowValues

        iBoardRow += 1
        if (iBoardRow == BOARD_SIZE)
            boards << board
        end

    end


end



f.close()

boards.each do | board |
    printBoard(board)
end

iDrawnNumbers = Array.new
keepLooping = true
iScore = -1

$iNumbersToDraw.each do | iValue |
    if (keepLooping)
        puts "value: #{iValue}"
        iDrawnNumbers << iValue

        i = 0
        boards.each do | board |
            if (isWinner(board, iDrawnNumbers))
                puts "Board #{i} wins"
                keepLooping = false

                iScore = getScore(board, iDrawnNumbers)
                puts "Score #{iScore}"

                puts "Last Drawn #{iValue}"
                puts "Result #{iValue * iScore}"
            
            end
            i += 1
        end
    end

end




