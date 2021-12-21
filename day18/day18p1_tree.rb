#2021 Levi D. Smith

class SnailfishNumber
    attr_accessor :elements
    attr_accessor :name
    attr_accessor :parent
    

    @@id = 0
    @@iActions = 0

    def initialize()
        iTimes = (@@id / 26).floor
        @name = ((0..iTimes).collect { | iTime |  ('A'.ord + (@@id % 26)).chr }).join
        @@id += 1
        @elements = Array.new(2)
        @parent = nil
        @@iActions = 0
    end


    def parse(strValue)
        iOpenIndex = 0
        iCommaIndex = -1
        iCloseIndex = -1

        i = 1
        iBracketCount = 1
        while (i < strValue.length)
            if (strValue[i] == "[")
                iBracketCount += 1
            elsif (strValue[i] == ",")
                if (iBracketCount == 1)
                    iCommaIndex = i

                    strFirstElement = strValue[iOpenIndex + 1..iCommaIndex - 1]
                    if (isNumber(strFirstElement))
                        @elements[0] = strFirstElement.to_i
                    else
                        snailfishnumber = SnailfishNumber.new()
                        snailfishnumber.parse(strFirstElement)
                        @elements[0] = snailfishnumber
                        snailfishnumber.parent = self
                    end

                end
            elsif (strValue[i] == "]")
                iBracketCount -= 1

                if (iBracketCount == 0)
                    iCloseIndex = i

                    strSecondElement = strValue[iCommaIndex + 1..iCloseIndex - 1]
                    if (isNumber(strSecondElement))
                        @elements[1] = strSecondElement.to_i
                    else
                        snailfishnumber = SnailfishNumber.new()
                        snailfishnumber.parse(strSecondElement)
                        @elements[1] = snailfishnumber
                        snailfishnumber.parent = self
                    end

                end
            end
            i += 1
        end



    end

    def isNumber(strValue)
        return strValue.match?(/^\d+$/)


    end

    def add(inSnailfishNumber)
        snailfishnumberResult = SnailfishNumber.new()
        snailfishnumberResult.elements[0] = self
        self.parent = snailfishnumberResult
        snailfishnumberResult.elements[1] = inSnailfishNumber
        inSnailfishNumber.parent = snailfishnumberResult



        return snailfishnumberResult
    end

    def to_s()
        str = "#{@name} pair: "

        if (@elements[0].instance_of?(SnailfishNumber))
            str += @elements[0].name
            puts @elements[0]
        else
            str += @elements[0].to_s
        end
        str += ", "
        if (@elements[1].instance_of?(SnailfishNumber))
            puts @elements[1]
            str += @elements[1].name
        else
            str += @elements[1].to_s
        end

        if (not parent.nil?)
            str += " (parent #{parent.name})"
        else
            str += " (parent nil)"
        end



        return str
    end

    def printSnailfishNumber()

        print "["
        if (elements[0].instance_of?(SnailfishNumber))
            print elements[0].printSnailfishNumber()
        else
            print elements[0]
        end
        print ","
        if (elements[1].instance_of?(SnailfishNumber))
            print elements[1].printSnailfishNumber()
        else
            print elements[1]
        end
        print "]"
    end

    def resetActions()
        @@iActions = 0
        @@strReduceType = "none"
    end

    def getActionCount()
        return @@iActions
    end

    def getReduceType()
        return @@strReduceType
    end

    def reduce(inDepth)
#        puts "Reducing #{@name}, depth: #{inDepth}"
#        puts "actions: #{@@iActions}"


        if (@@iActions < 1)
            if (inDepth == 4)
#                puts "Explode #{@name}"
#                print "explode"
                @@strReduceType = "explode"
                @@iActions += 1
                addNumberLeft(elements[0])
                addNumberRight(elements[1])

                if (parent.elements[0] === self)
                    parent.elements[0] = 0
                    
                elsif (parent.elements[1] === self)
                    parent.elements[1] = 0
                    
                end

            end
        end


        if (@@iActions < 1)
            nodeLeft = elements[0]
            if ((not nodeLeft.instance_of?(SnailfishNumber)) && (nodeLeft >= 10))
                @@strReduceType = "split"
                elements[0] = createSplitNode(nodeLeft)
                @@iActions += 1
                
            end
        end

        if (@@iActions < 1)
            nodeRight = elements[1]
            if ((not nodeRight.instance_of?(SnailfishNumber)) && (nodeRight >= 10))
                @@strReduceType = "split"
                elements[1] = createSplitNode(nodeRight)
                @@iActions += 1
                
            end
        end


        if (elements[0].instance_of?(SnailfishNumber))
            elements[0].reduce(inDepth + 1)
        end

        if (elements[1].instance_of?(SnailfishNumber))
            elements[1].reduce(inDepth + 1)
        end


    end

    def addNumberLeft(iValue)
        splitNode = nil

        keepLooping = true
        node = self
        while (keepLooping)
            
            if (not node.parent.nil?)
                nodeRight = node.parent.elements[1]
            else
                keepLooping = false
            end

            if not ((node.parent.nil?) || (nodeRight === node))
                node = node.parent
            else
                if (not node.parent.nil?)
#                    puts "split at #{node.parent.name}"
                    splitNode = node.parent
                    keepLooping = false
                end
            end
        end

        if (not splitNode.nil?)
            node = splitNode
            if (not node.elements[0].instance_of?(SnailfishNumber))
#                puts "leaf node is #{node.name} #{node.elements[0]}"
                node.elements[0] += iValue
            else
                node = node.elements[0]
                while (node.elements[1].instance_of?(SnailfishNumber))
                    node = node.elements[1]
                end

                #should have reached the leaf node, which is a regular number
#                puts "leaf node is #{node.name} #{node.elements[1]}"
                node.elements[1] += iValue
            end
        end
        
        
    end

    def addNumberRight(iValue)
#        puts "addNumberRight #{iValue}"

        #Go up until either parent is nil OR this node is the parent's left
        splitNode = nil

        keepLooping = true
        node = self
        while (keepLooping)
            
            if (not node.parent.nil?)
                nodeLeft = node.parent.elements[0]
            else
                keepLooping = false
            end

            if not ((node.parent.nil?) || (nodeLeft === node))
#                puts "getting parent #{node.parent.name}"
                node = node.parent
            else
                if (not node.parent.nil?)
#                    puts "split at #{node.parent.name}"
                    splitNode = node.parent
                    keepLooping = false
                end
            end
        end

        if (not splitNode.nil?)
        #Go down left nodes until a regular number is found

            node = splitNode
            if (not node.elements[1].instance_of?(SnailfishNumber))
#                puts "leaf node is #{node.name} #{node.elements[1]}"
                node.elements[1] += iValue
            else
                node = node.elements[1]
                while (node.elements[0].instance_of?(SnailfishNumber))
                    node = node.elements[0]
                end

                #should have reached the leaf node, which is a regular number
#                puts "leaf node is #{node.name} #{node.elements[0]}"
                node.elements[0] += iValue
            end
        end
    end

    def createSplitNode(iValue)
#        print "split"
        node = SnailfishNumber.new()
        node.elements[0] = (iValue / 2.0).floor
        node.elements[1] = (iValue / 2.0).ceil
        node.parent = self
        return node
    end


end


strFile = ARGV[0]


f = File.open(ARGV[0])

snailfishnumbers = Array.new

f.readlines().each do | strLine |
#    puts strLine.chomp
    strInput = strLine.chomp


    if ((not strInput.start_with?("#")) && (strInput != ""))
        puts strInput
        snailfishnumber = SnailfishNumber.new()
        snailfishnumber.parse(strLine.chomp)
        snailfishnumbers << snailfishnumber

#        snailfishnumber.reduce(0)
#        snailfishnumber.printSnailfishNumber
        puts "==================="
    end


end



f.close()

#puts snailfishnumbers[0]
#puts snailfishnumbers[1]

#puts "Result: #{snailfishnumbers[0].add(snailfishnumbers[1])}"
#puts
#puts snailfishnumbers[0].add(snailfishnumbers[1]).printSnailfishNumber()

snailfishSum = nil
snailfishnumbers.each do | snailfishnumber |

    if (snailfishSum.nil?)
        snailfishSum = snailfishnumber
        
        

    else
        snailfishSum = snailfishSum.add(snailfishnumber)
        print "after addition: "
        snailfishSum.printSnailfishNumber()
        puts

        keepLooping = true
        while (keepLooping)
            print "after "
            snailfishSum.resetActions()
            snailfishSum.reduce(0)
            print snailfishSum.getReduceType()
            print ": "
            snailfishSum.printSnailfishNumber()
            puts

            if (snailfishSum.getActionCount() == 0)
                keepLooping = false
            end


        end

    end

end

