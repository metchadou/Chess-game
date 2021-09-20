require "byebug"
require_relative "piece"
require_relative "slideable"

class Bishop < Piece
  include Slideable

  def self.starting_positions(color)
    if color == :black
      [[0,2], [0,5]]
    else
      [[7,2], [7,5]]
    end
  end
  
  def initialize(color, board, pos)
    super
  end

  def symbol
    :B
  end

  def move_dirs
    diagonal_dirs
  end
end