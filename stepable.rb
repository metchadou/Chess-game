require "byebug"

module Stepable
  
  def moves
    moves  = []

    move_diffs.each do |end_pos|
      potential_move = [self.position, end_pos].transpose.map(&:sum)

      if self.board.in_board?(potential_move) && !blocked_move?(potential_move)
        moves << potential_move
      end
    end

    moves.uniq
  end
  
  
  def blocked_move?(pos)
    # A piece cannot move to a position occupied by another
    # piece of the same color
    self.board[pos].color == self.color
  end

  private
  
  def move_diffs 
  end
  
end