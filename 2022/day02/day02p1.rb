#2022 Levi D. Smith (levidsmith.com)
f = File.new(ARGV[0])

iTotalPoints = 0
f.each do | line |
    puts "line: #{line}"

    opChoice = line[0].ord - 'A'.ord
    myChoice = line[2].ord - 'X'.ord
    
    puts "op: #{opChoice} me: #{myChoice}"

    pointsChoice = myChoice + 1

    pointsWin = 0
    if (opChoice == myChoice)
        puts "Draw"
        pointsWin = 3
    elsif ( opChoice == (myChoice + 1) % 3)
        puts "Lose"
        pointsWin = 0
    elsif ( myChoice == (opChoice + 1) % 3)
        puts "Win"
        pointsWin = 6

    end

    iRoundPoints = pointsChoice + pointsWin

    puts "Round points: #{iRoundPoints}"
    iTotalPoints += iRoundPoints
end

puts "Total points: #{iTotalPoints}"