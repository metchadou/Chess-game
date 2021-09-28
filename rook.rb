require "byebug"
require_relative "piece"
require_relative "slideable"

class Rook < Piece
  include Slideable

  def self.starting_positions(color)
    if color == :black
      [[0,0], [0,7]]
    else
      [[7,0], [7,7]]
    end
  end
  
  def initialize(color, board, position)
    super
  end

  def symbol
    :R
  end

  def move_dirs
    vertical_dirs + horizontal_dirs
  end
end