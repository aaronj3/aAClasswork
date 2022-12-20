require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    # build a TicTacToeNode from the board stored in the game passed in as an argument.
    @node = TicTacToeNode.new(game.board, mark)
    
    # iterate through the children of the node
    @node.children.each do |child|
      # If any of the children is a winning_node? for the mark passed in to the #move method, return that node's prev_move_pos
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    # raise an error if there are no non-losing nodes.  
    raise 'error' if @node.children.none?{|child| !child.losing_node?(mark)}
    # If none of the children of the node we created are winning_node?s, that's ok.
    #  pick one that isn't a losing_node? and return its prev_move_pos
    @node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
