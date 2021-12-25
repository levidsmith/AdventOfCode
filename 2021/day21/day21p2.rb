#2021 Levi D. Smith

class Die
    MAX_VALUE = 3
    attr_accessor :iValue
    attr_accessor :rollValues

    def initialize()
        @iValue = 0
        @rollValues = nil
    end

    def roll()
        @iValue = @rollValues.pop

    end
end

class Board
    attr_accessor :isGameOver
    MAX_SPACES = 10
    POINTS_TO_WIN = 21

    def initialize()
        @pawns = Array.new
        @mapPawnSpace = Hash.new
        @mapPawnStartingSpace = Hash.new
        @die = Die.new()

        @inputs = Array.new

        for i in (0...27)
            @inputs << createInput(i)
        end


    end

    def createInput(iSeed)
        input = Array.new

        firstRoll = iSeed % 3
        secondRoll = (iSeed / 3).floor % 3
        thirdRoll = (iSeed / 9).floor % 3

        firstRoll += 1
        secondRoll += 1
        thirdRoll += 1

        puts "firstRoll #{firstRoll} secondRoll #{secondRoll} thirdRoll #{thirdRoll}"

        #return [firstRoll, secondRoll, thirdRoll, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        for i in (0...16) do
            input << 1
        end
        input << firstRoll
        input << secondRoll
        input << thirdRoll

        return input

    end

    def startGame()
        @inputs.each do | input |
        
            @die.rollValues = input
            restartGame()
            while (not @isGameOver)
                playTurn()
                nextPlayer()
            end

        end

        puts "Player 1 total wins #{@pawns[0].iWins}"
        puts "Player 2 total wins #{@pawns[1].iWins}"


    end

    def restartGame()
        @iCurrentPlayer = 0
        @isGameOver = false

        for iPawn in (0...@pawns.length)
            @mapPawnSpace[@pawns[iPawn]] = @mapPawnStartingSpace[@pawns[iPawn]]
            @pawns[iPawn].iScore = 0
            
        end

    end

    def setPawnSpace(iPawn, iSpace)
        @mapPawnSpace[@pawns[iPawn]] = iSpace
        @mapPawnStartingSpace[@pawns[iPawn]] = iSpace
    end

    def playTurn()

#        print "Player #{@iCurrentPlayer + 1} rolls "

        iMoveSpaces = 0
        (0...3).each do 
            @die.roll()
 #           print "#{@die.iValue},"
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
#        print " and moves to space #{iNextSpace + 1}"
        @mapPawnSpace[@pawns[@iCurrentPlayer]] = iNextSpace

        
        @pawns[@iCurrentPlayer].iScore += @mapPawnSpace[@pawns[@iCurrentPlayer]] + 1
#        puts " for a total score of #{@pawns[@iCurrentPlayer].iScore}"

        if (@pawns[@iCurrentPlayer].iScore >= POINTS_TO_WIN)
            @isGameOver = true

            iWinningScore = @pawns[@iCurrentPlayer].iScore
            iLosingScore = @pawns[(@iCurrentPlayer + 1) % @pawns.length].iScore
#            puts "Winning Score: #{iWinningScore}"
#            puts "Losing Score: #{iLosingScore}"

#            puts "Player #{@iCurrentPlayer + 1} wins"
            @pawns[@iCurrentPlayer].iWins += 1

#            puts "Player 1 wins #{@pawns[0].iWins}"
#             puts "Player 2 wins #{@pawns[1].iWins}"

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
    attr_accessor :iWins
    def initialize()
        @iScore = 0
        @iWins = 0
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

board.startGame()

#while (not board.isGameOver)

#    board.playTurn()
#    board.nextPlayer()
#end

f.close()
