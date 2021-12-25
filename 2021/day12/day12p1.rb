#2021 Levi D. Smith
strFile = ARGV[0]

class CaveGraph
    attr_accessor :nodes
    attr_accessor :edges;
    
    def initialize()
        
        @nodes = Array.new
        @edges = Array.new
        @iPathCount = 0
    end

    def addNode(strName)

        if (not @nodes.include? strName)
            node = CaveNode.new(strName)
            @nodes << node
        end

    end

    def addEdge(strNode1, strNode2)
        node1 = @nodes[@nodes.index(strNode1)]
        node2 = @nodes[@nodes.index(strNode2)]
        @edges << CaveEdge.new(node1, node2)

    end

    def displayAllNodes()
        puts "Nodes:"
        @nodes.each do | node |
            puts node

        end
    end

    def displayAllEdges()
        puts "Edges:"
        @edges.each do | edge |
            puts edge

        end
    end

    def traverseGraph()
        @nodes.each do | node |
                if (node.isStart)
                    path = Array.new
                    traverseEdges(node, path)
                end
        end

        puts "Paths: #{@iPathCount}"
    end

    def traverseEdges(inNode, inPath)
        inPath << inNode
#        puts "traverseEdges: #{inNode} path: #{inPath}"

        if (inNode.isEnd)
            @iPathCount += 1
            inPath.each do | node |
                print "#{node}"
                if (not node.isEnd)
                    print ","
                end
            end
            puts
        end

        @edges.each do | edge |
#            puts "Checking edge: #{edge}, node1: #{nodes[0]} node2: #{nodes[1]}"

            toNode = nil
            if (inNode === edge.nodes[0])
               toNode = edge.nodes[1] 
            end

            if (inNode === edge.nodes[1])
                toNode = edge.nodes[0] 
             end
 

            if (not toNode.nil?)
                if (toNode.isLarge or (toNode.isSmall and not inPath.include? toNode))
                    traverseEdges(toNode, inPath.clone)
                end
            end

        end

    end

end

class CaveNode
    attr_accessor :strName

    def initialize(strInName)
        @strName = strInName
    end

    def ==(strNode)
        b = true
        if (@strName == strNode)
            b = true
       
        else
            b = false
                
        end

        return b
    end


    def to_s
        str = @strName

#        str = "Node: #{@strName}"
#        if (isStart)
#            str += " (start) "  
#        elsif (isEnd)
#            str += " (end) "
#        elsif (isSmall)
#           str += " (small) " 
#        elsif
#            str += " (large) " 
#        end

        return str
    end

    def isStart()
        if (@strName == "start")
            isStart = true
        else
            isStart = false
        end

        return isStart
    end

    def isEnd()
        if (@strName == "end")
            isEnd = true
        else
            isEnd = false
        end
    end


    def isSmall()
        isSmall = true

        @strName.chars.each do | c |
            if not (c.ord >= "a"[0].ord and c.ord <= "z"[0].ord)
                isSmall = false
            end
        end

        return isSmall

    end

    def isLarge()
        isLarge = true

        @strName.chars.each do | c |
            if not (c.ord >= "A"[0].ord and c.ord <= "Z"[0].ord)
                isLarge = false
            end
        end

        return isLarge

    end


end

class CaveEdge
    attr_accessor :nodes
    
    def initialize(inNode1, inNode2)
        @nodes = Array.new(2) #should only contain two nodes
        nodes[0] = inNode1
        nodes[1] = inNode2
    end    

    def to_s
        return "Edge: #{@nodes[0]} - #{@nodes[1]}"
    end
    
end


cavegraph = CaveGraph.new

f = File.open(ARGV[0])

f.readlines().each do | strLine |
    puts strLine.chomp
    strTokens = strLine.chomp.split("-")
    node1 = strTokens[0]
    node2 = strTokens[1]
    cavegraph.addNode(node1)
    cavegraph.addNode(node2)
    cavegraph.addEdge(node1, node2)

end

f.close()

puts
cavegraph.displayAllNodes()
cavegraph.displayAllEdges()

puts
puts "Traverse Graph: "
cavegraph.traverseGraph()
