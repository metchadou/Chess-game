require "byebug"

class Piece

  attr_accessor :board
  attr_reader :color, :position
  def initialize(color, board, position)
    @color, @board, @position = color, board, position
  end

  def to_s
    " #{symbol} "
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

  def valid_moves
    moves.reject {|pos| move_into_check?(pos)}
  end

  def move_into_check?(end_pos)
    board_dup = @board.deep_dup

    board_dup.update_board_ref_of_pieces
    board_dup.move_piece!(@position, end_pos)
    board_dup.in_check?(@color)
  end

end