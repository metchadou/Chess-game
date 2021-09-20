require "byebug"
require_relative "stepable"

class King < Piece
  include Stepable

  def self.starting_positions(color)
    if color == :black
      [[0,4]]
    else
      [[7,4]]
    end
  end

  def initialize(color, board, pos)
    super
  end

  def symbol
    :K
  end

  protected

  def move_diffs
    [[1,1], [1,-1], [-1,-1], [-1,1],
     [1, 0], [-1, 0], [0,1], [0,-1]]
  end

end