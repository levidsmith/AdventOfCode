#2021 Levi D. Smith
strFile = ARGV[0]

f = File.open(ARGV[0])


m = nil
xRange = nil
yRange = nil
f.readlines().each do | strLine |
    puts strLine.chomp
    strInput = strLine.chomp

    m = strLine.match(/target area: x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)/)

    puts "x1: #{m[1]} x2: #{m[2]} y1: #{m[3]} y4: #{m[4]}"
    xRange = m[1].to_i..m[2].to_i
    yRange = m[3].to_i..m[4].to_i

end

f.close()

iCount = 0

u = xRange.max
v = yRange.min

puts "u: #{u} v: #{v}"


BIG_NUMBER = 400 #keep increasing this until the yBest doesn't change anymore to get the answer
                 #not the best solution, but couldn't figure out the correct way to
                 #get the upper bound

iCount = 0
yBest = 0
for xVel in (1..u)
    for yVel in (v..BIG_NUMBER)
#        puts "#{xVel}, #{yVel}"

    puts "xVel: #{xVel} yVel: #{yVel}"
        xVelOrig = xVel
        yVelOrig = yVel
        yMax = 0

        xVel1 = xVel
        xCurrent = 0
        yCurrent = 0
    
    
        ( xCurrent += xVel1
        yCurrent += yVel
        if (yCurrent > yMax)
            yMax = yCurrent
        end

        xVel1 -= xVel1 <=> 0
    
        yVel -= 1
        if (xRange === xCurrent && yRange === yCurrent)
#            puts "xVel: #{xVel} yVel: #{yVel}"
            puts "hit using #{xVelOrig}, #{yVelOrig}, highest: #{yMax}"
            if (yMax > yBest)
                yBest = yMax
            end
            iCount += 1
            break
        end
        ) until yCurrent < v

    end
end

#puts "yBest #{yBest}"
puts "Hit count: #{iCount}"

