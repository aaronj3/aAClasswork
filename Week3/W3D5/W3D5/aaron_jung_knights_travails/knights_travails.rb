require_relative "../poly_tree_node/lib/00_tree_node.rb"


class KnightPathFinder
    attr_reader :root_node, :considered_positions
    def self.valid_moves(pos)
        moves = [[1,2], [-1,2], [1,-2],[-1,-2], [2,1], [-2,1], [2, -1], [-2,-1]] 
        row, col = pos[0], pos[1]
        moves.select do |move|
            move_row, move_col = move
            new_pos = [move_row + row, move_col + col]
            new_pos if new_pos[0].between?(0, 7) && new_pos[1].between?(0, 7) 
        end
    end

    def initialize(starting_pos)
        @root_node = PolyTreeNode.new(starting_pos)
        @considered_positions = [starting_pos]
        # build_move_tree
    end
    
    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        possible_positions = moves.map{|move| [pos[0] + move[0], pos[1] + move[1]]}
        possible_positions.select {|pos| !@considered_positions.include?(pos)}
    end

    def build_move_tree 
        node_queue = [@root_node]
        until node_queue.empty?
            current_node = node_queue.shift
            new_move_positions(current_node.value).each do |pos|
                child_node = PolyTreeNode.new(pos)
                current_node.add_child(child_node) if !@considered_positions.include?(pos)
                @considered_positions << pos
                node_queue << child_node
            end
        end
        root_node
    end
    
    def find_path(end_pos)
        end_node = root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        path = [end_node.value]
        current_node = end_node
        until current_node == @root_node
            current_node = current_node.parent
            path.unshift(current_node.value)
        end
        # path.unshift(current_node.value)
        path
    end







    # def find_path(ending_pos)
    #     return nil if !ending_pos[0].between?(0, 7) || !ending_pos[1].between?(0, 7)
    #     path = [@tree.value]
    #     node = @tree.bfs(ending_pos)
    #     parent_node = node.parent if node.parent parent != nil
    #     until parent_node == nil
    #         path << parent_node.value
    #         parent_node = parent_node.parent
    #     end
    #     path
    # end

end

kpf = KnightPathFinder.new([0, 0])
kpf.build_move_tree




