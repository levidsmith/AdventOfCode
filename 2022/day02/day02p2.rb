#2022 Levi D. Smith (levidsmith.com)
f = File.new(ARGV[0])

iTotalPoints = 0
f.each do | line |
    puts "line: #{line}"

    opChoice = line[0].ord - 'A'.ord

    cOutcome = line[2]
    if (cOutcome == "X")
        myChoice = (opChoice + 2) % 3
        pointsWin = 0
    elsif (cOutcome == "Y")
        myChoice = opChoice
        pointsWin = 3
    elsif (cOutcome == "Z")
        myChoice = (opChoice + 1) % 3
        pointsWin = 6
    end
    
    puts "op: #{opChoice} me: #{myChoice}"

    pointsChoice = myChoice + 1

    iRoundPoints = pointsChoice + pointsWin

    puts "Round points: #{iRoundPoints}"
    iTotalPoints += iRoundPoints
end

puts "Total points: #{iTotalPoints}"