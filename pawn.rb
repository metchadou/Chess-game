require "byebug"
require_relative "piece"

class Pawn < Piece

  def self.starting_positions(color)
    if color == :black
      [[1,0], [1,1], [1,2], [1,3],
       [1,4], [1,5], [1,6], [1,7]]
    else
      [[6,0], [6,1], [6,2], [6,3],
       [6,4], [6,5], [6,6], [6,7]]
    end
  end

  attr_reader :color, :board, :pos
  def initialize(color, board, pos)
    super
  end

  def symbol
    :P
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def unblocked_step?(pos)
    board[pos].empty? 
  end

  def at_start_row?
    start_row = nil
    forward_dir == 1 ? start_row = 1 : start_row = 6

    position[0] == start_row
  end

  def forward_dir
    color == :black ? 1 : -1
  end

  def forward_steps
    steps = []
    next_pos = [position[0]+(forward_dir), position[1]]

    if unblocked_step?(next_pos)
      steps << next_pos
      
      next_pos = [next_pos[0]+(forward_dir), next_pos[1]]
      if at_start_row? && unblocked_step?(next_pos)
        steps << next_pos
      end
    end

    steps
  end

  def side_attacks
    next_step = [position[0] + forward_dir, position[1]]
    next_rank = next_step[0]
    left_side, right_side = next_step[1] - 1, next_step[1] + 1
    potential_attacks = [[next_rank, left_side], [next_rank, right_side]]

    potential_attacks.select do |pos|
      board.in_board?(pos) && enemy?(pos)
    end
  end

  def enemy?(pos)
    piece = board[pos]
    # If a piece does not have the same color as self
    # and is not a null piece, then it is the opponent's piece
    piece.color != color && piece.symbol != :NULL
  end

end