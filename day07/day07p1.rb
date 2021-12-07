#2021 Levi D. Smith


strFile = ARGV[0]
iInputs = Array.new

f = File.open(strFile)

iInputs = f.readlines[0].chomp.split(",").collect { |x| x.to_i }

f.close()



iTotals = Array.new
(iInputs.min()..iInputs.max()).each do | iAlign |
    iTotalFuel = 0
    iInputs.each do | iValue |
        iFuel = (iValue - iAlign).abs
        puts "Move from #{iValue} to #{iAlign}: #{iFuel}"
        iTotalFuel += iFuel

    end
    puts "Total Fuel: #{iTotalFuel}"
    iTotals << iTotalFuel
end

puts "Least total: #{iTotals.min()}"


