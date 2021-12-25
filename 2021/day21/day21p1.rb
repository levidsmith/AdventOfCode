#2021 Levi D. Smith

class Die
    MAX_VALUE = 100
    attr_accessor :iValue
    attr_accessor :iTimesRolled

    def initialize()
        @iValue = 0
        @iTimesRolled = 0
    end

    def roll()
        @iValue += 1
        if (@iValue > MAX_VALUE )
            @iValue = 1
        end
        @iTimesRolled += 1

    end
end

class Board
    attr_accessor :isGameOver
    MAX_SPACES = 10
    POINTS_TO_WIN = 1000

    def initialize()
        @iCurrentPlayer = 0
        @pawns = Array.new
        @mapPawnSpace = Hash.new
        @isGameOver = false
        @die = Die.new()

    end

    def setPawnSpace(iPawn, iSpace)
        @mapPawnSpace[@pawns[iPawn]] = iSpace
    end

    def playTurn()

        print "Player #{@iCurrentPlayer + 1} rolls "

        iMoveSpaces = 0
        (0...3).each do 
            @die.roll()
            print "#{@die.iValue},"
            iMoveSpaces += @die.iValue

        end

        moveCurrentPlayerSpaces(iMoveSpaces)

    end

    def moveCurrentPlayerSpaces(iSpaces)
        iCurrentSpace = @mapPawnSpace[@pawns[@iCurrentPlayer]]
        iNextSpace = iCurrentSpace + iSpaces
        if (iNextSpace > MAX_SPACES)
            iNextSpace = iNextSpace % MAX_SPACES

        end
        print " and moves to space #{iNextSpace + 1}"
        @mapPawnSpace[@pawns[@iCurrentPlayer]] = iNextSpace

        
        @pawns[@iCurrentPlayer].iScore += @mapPawnSpace[@pawns[@iCurrentPlayer]] + 1
        puts " for a total score of #{@pawns[@iCurrentPlayer].iScore}"

        if (@pawns[@iCurrentPlayer].iScore >= POINTS_TO_WIN)
            @isGameOver = true

            iWinningScore = @pawns[@iCurrentPlayer].iScore
            iLosingScore = @pawns[(@iCurrentPlayer + 1) % @pawns.length].iScore
            puts "Winning Score: #{iWinningScore}"
            puts "Losing Score: #{iLosingScore}"
            puts "Times Rolled: #{@die.iTimesRolled}"

            puts "Result: #{iLosingScore * @die.iTimesRolled}"
        end


    end

    def nextPlayer()
        @iCurrentPlayer += 1
        if (@iCurrentPlayer >= @pawns.length)
            @iCurrentPlayer = 0
        end
    end

    def addPlayer(iStartingPosition)
        puts "adding player at position #{iStartingPosition}"
        pawn = Pawn.new
        @pawns << pawn
        setPawnSpace(@pawns.length - 1, iStartingPosition)
    end

end

class Pawn
    attr_accessor :iScore
    def initialize()
        @iScore = 0
    end
end

strFile = ARGV[0]

pawns = Pawn.new()
board = Board.new()



f = File.open(ARGV[0])



f.readlines().each do | strLine |
    strInput = strLine.chomp

    if (not strInput.start_with?("#"))
        #puts strInput
        m = strInput.match(/Player (\d+) starting position: (\d+)/)

        puts "#{m[1]} #{m[2]}"
        board.addPlayer(m[2].to_i - 1)
    end

end

while (not board.isGameOver)

    board.playTurn()
    board.nextPlayer()
end

f.close()
