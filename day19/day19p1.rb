#2021 Levi D. Smith

class Scanner
    attr_accessor :beacons


    def initialize(inID)
        @id = inID
        @beacons = Array.new
    end

    def addBeacon(inBeacon)
        @beacons << inBeacon
    end

    def checkOverlap(inScanner)

        @beacons.each do | beacon |
            inScanner.beacons.each do | beaconCheck |
                xOffset = beacon.x - beaconCheck.x
                yOffset = beacon.y - beaconCheck.y
                zOffset = beacon.z - beaconCheck.z

                isValid = validateBeaconOffset(@beacons, inScanner.beacons, xOffset, yOffset, zOffset)
                if (isValid)
                    puts "Offset is #{xOffset}, #{yOffset}, #{zOffset},"
                end
            end
        end


#        puts "Offset is #{xOffset}, #{yOffset}"

    end


    def validateBeaconOffset(beacons1, beacons2, xOffset, yOffset, zOffset)
        allMatched = false
#        puts "check offset #{xOffset}, #{yOffset}"
        i1 = 0
        iMatchCount = 0
        beacons1.each do | beacon1 |
            i2 = 0
            beacons2.each do | beacon2 |
                if (beacon1.x - xOffset == beacon2.x &&
                    beacon1.y - yOffset == beacon2.y &&
                    beacon1.z - zOffset  == beacon2.z)
                    foundMatch = true
#                    puts "beacon #{i1} matched beacon #{i2}"
                    iMatchCount += 1
                end

                i2 += 1
            end

#            puts "match count: #{iMatchCount}"
            if (iMatchCount == beacons1.length)
#                puts "All matched"
                allMatched = true
            end

            i1 += 1
        end

        return allMatched
    end

end

class Beacon
    attr_accessor :x
    attr_accessor :y
    attr_accessor :z

    def initialize(inX, inY, inZ)
        @x = inX
        @y = inY
        @z = inZ

    end


    def to_s()
        return "Beacon: #{x}, #{y}, #{z}"
    end
end


strFile = ARGV[0]


f = File.open(ARGV[0])

scanners = Array.new
scanner = nil

f.readlines().each do | strLine |
    strInput = strLine.chomp

    if (not strInput.start_with?("#"))
#        puts strInput

        m = strInput.match(/--- scanner (\d+) ---/)
        if (not m.nil?)
            puts "Scanner: #{m[1]}"
            scanner = Scanner.new(m[1].to_i)
            scanners << scanner
        end

        m = strInput.match(/(-?\d+),(-?\d+),(-?\d+)/)
        if (not m.nil?)
            beacon = Beacon.new(m[1].to_i, m[2].to_i, m[3].to_i)
            puts beacon
            scanner.addBeacon(beacon)
        end


    end


end

f.close()

scanners[0].checkOverlap(scanners[1])
