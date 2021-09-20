require "byebug"
require_relative "stepable"

class Knight < Piece
  include Stepable

  def self.starting_positions(color)
    if color == :black
      [[0,1], [0,6]]
    else
      [[7,1], [7,6]]
    end
  end

  def initialize(color, board, position)
    # debugger
    super
  end

  def symbol
    :N
  end

  protected

  def move_diffs
    [[-2,1], [-2,-1], [-1,2], [1,2],
     [2,1], [2,-1], [1,-2], [-1,-2]]
  end

end