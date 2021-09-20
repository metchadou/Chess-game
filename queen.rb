require "byebug"
require_relative "piece"
require_relative "slideable"

class Queen < Piece
  include Slideable

  def self.starting_positions(color)
    if color == :black
      [[0,3]]
    else
      [[7,3]]
    end
  end
  
  def initialize(color, board, pos)
    super
  end

  def symbol
    :Q
  end

  def move_dirs
    vertical_dirs + horizontal_dirs + diagonal_dirs
  end
end