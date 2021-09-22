require "byebug"
require "singleton"
require_relative "piece"

class NullPiece < Piece
  include Singleton
  
  attr_reader :color
  def initialize
    @color = nil
  end

  def symbol
    :NULL
  end

  def moves
  end

  def inspect
    {symbol: symbol}.inspect
  end

  def to_s
    "   "
  end

end