require "byebug"
require_relative "piece"
require_relative "king"
require_relative "queen"
require_relative "bishop"
require_relative "knight"
require_relative "rook"
require_relative "pawn"
require_relative "nullpiece"

class EmptyPositionError < StandardError
  def message
    "Selected position has no piece"
  end
end

class ForbiddenMoveError < StandardError
  def message
    "This move is not allowed"
  end
end

class Board
  
  attr_reader :rows
  def initialize
    @rows = Array.new(8) {Array.new(8)}

    place_pieces
  end

  def [](pos)
    row, col = pos
    rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    rows[row][col] = value
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def move_piece(start_pos, end_pos)
    start_piece = self[start_pos] # Piece at start position

    raise EmptyPositionError if start_piece.symbol == :NULL
    raise ForbiddenMoveError if !start_piece.moves.include?(end_pos)

    self[start_pos] = NullPiece.instance
    start_piece.position = end_pos
    self[end_pos] = start_piece
  end

  def in_board?(pos)
    pos.all? {|idx| idx.between?(0,7)}
  end

  # Place pieces at their initial positions when game starts
  def place_pieces
    colors = [:black, :white]
    piece_classes = [King, Queen, Bishop, Knight, Rook, Pawn]

    colors.each do |color|
      piece_classes.each do |piece|
        piece.starting_positions(color).each do |pos|
          add_piece(piece.new(color, self, pos), pos)
        end
      end
    end

    place_null_piece
  end

  def place_null_piece
    (0...rows.length).each do |row|
      (0...rows.length).each do |col|
        pos = [row, col]
        self[pos] = NullPiece.instance if self[pos].nil?
      end
    end
  end

end