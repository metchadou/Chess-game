require "byebug"

class Piece

  attr_reader :color, :board, :position
  def initialize(color, board, position)
    @color, @board, @position = color, board, position
  end

  def to_s
    "#{symbol}"
  end

  def empty?
    color.nil?
  end

  def position=(val)
    @position = val
  end

  def symbol
  end

  def inspect
    {symbol: symbol, color: color, pos: position}.inspect
  end

end