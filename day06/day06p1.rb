#2021 Levi D. Smith

strFile = ARGV[0]

DEBUG = true


f = File.open(strFile)

lines = Array.new

f.readlines().each do  | strLine | 
#    puts strLine.chomp
    lines << strLine.chomp

end

f.close()

iAllFish = lines[0].split(",").collect { | str | str.to_i }

puts "Initial State: " + iAllFish.join(",")

SIMULATE_DAYS = 18
#SIMULATE_DAYS = 80
iDay = 0

while (iDay < SIMULATE_DAYS)


    iFishToAdd = 0
    iAllFish.collect! { | iFish |

        if (iFish <= 0)
            iFishToAdd += 1
            6
            
        else
            iFish - 1
        end
    }

    (0...iFishToAdd).each do
        iAllFish << 8
    end

    if (DEBUG)
        print "After #{iDay + 1} days: "
        i = 0
        iAllFish.each do | iFish |
            print "#{iFish}"

            if (i < iAllFish.length - 1)
                print ","
            end
            i += 1
        end
    end


    iDay += 1
    if (DEBUG)
        puts ""
    end
end


puts "Result: #{iAllFish.length}"

