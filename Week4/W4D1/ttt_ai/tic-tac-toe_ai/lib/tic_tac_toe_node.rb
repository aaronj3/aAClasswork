require_relative 'tic_tac_toe'

class TicTacToeNode 
  #This class represents a TTT game-state
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark 
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  #     Base case: the board is over AND
  # If winner is the opponent, this is a losing node.
  # If winner is nil or us, this is not a losing node.
    if (@board.won? && @board.winner == evaluator) || @board.tied?
      return false
    elsif @board.won? && @board.winner != evaluator
      return true
    end
  # Recursive case:
  # It is the player's turn, and all the children nodes are losers for the player (anywhere they move they still lose), OR
   if next_mover_mark == evaluator
    return self.children.all? {|child| child.losing_node?(evaluator)}
    # It is the opponent's turn, and one of the children nodes is a losing node for the player
   else
    return self.children.any? {|child| child.losing_node?(evaluator)}
   end
   false
  end


  def winning_node?(evaluator)
    if @board.won? && @board.winner == evaluator
      return true
    elsif @board.over? && @board.winner != evaluator 
      return false
    end

    if next_mover_mark == evaluator
      return self.children.any? {|child| child.winning_node?(evaluator)}
     else
      return self.children.all? {|child| child.winning_node?(evaluator)}
    end
    false
  end
  

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    # iterate through all positions that are empty? on the board object
    children_nodes = []
    # p board
    (0...3).each do |row|
      (0...3).each do |col|
        if @board.empty?([row, col])
          # For each empty position, create a node by duping the board and putting a next_mover_mark in the position. 
          # alternate next_mover_mark so that next time the other player gets to move.
          #  set prev_move_pos to the position you just marked
          new_board = @board.dup
          pos = [row, col]
          new_board[pos]= next_mover_mark
          if next_mover_mark == :x
            children_nodes << TicTacToeNode.new(new_board, :o, [row, col])
          else
            children_nodes << TicTacToeNode.new(new_board, :x, [row, col])
          end
        end
      end
    end
    children_nodes
  end



  
end
