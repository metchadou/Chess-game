require "byebug"
require_relative "piece"
require_relative "king"
require_relative "queen"
require_relative "bishop"
require_relative "knight"
require_relative "rook"
require_relative "pawn"
require_relative "nullpiece"

class Array
  def deep_dup
    if self.none? {|el| el.is_a?(Array)}
      return self.map do |el|
        if el.class.ancestors.include?(Singleton)
          el
        else
          el.dup
        end
      end
    end

    self.map {|el| el.deep_dup}
  end

end

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

class MoveInCheckError < StandardError
  def message
    "This move leaves one of your piece in check"
  end
end

class MovingOpponentPieceError < StandardError
  def message
    "That is your opponent piece"
  end
end

class Board
  
  attr_accessor :rows
  def initialize
    @null_piece = NullPiece.instance
    @rows = Array.new(8) {Array.new(8, @null_piece)}

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

  def in_board?(pos)
    pos.all? {|idx| idx.between?(0,7)}
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def move_piece(color, start_pos, end_pos)
    start_piece = self[start_pos] # Piece at start position
    
    raise EmptyPositionError if start_piece == @null_piece
    raise MovingOpponentPieceError if start_piece.color != color
    raise ForbiddenMoveError if !start_piece.moves.include?(end_pos)
    raise MoveInCheckError if !start_piece.valid_moves.include?(end_pos)

    self[start_pos] = @null_piece
    start_piece.position = end_pos
    self[end_pos] = start_piece
  end

  def move_piece!(start_pos, end_pos)
    start_piece = self[start_pos]
    self[start_pos] = @null_piece
    start_piece.position = end_pos
    self[end_pos] = start_piece
  end

  def checkmate?(color)
    in_check?(color) &&
    player_pieces(color).all? {|piece| piece.valid_moves.empty?}
  end

  def in_check?(color)
    king_pos = king_position(color)

    opposing_pieces(color).any? do |piece|
      piece.moves.include?(king_pos)
    end
  end

  def deep_dup
    board_copy = self.dup
    board_copy.rows = board_copy.rows.deep_dup

    board_copy
  end

  def update_board_ref_of_pieces
    pieces.each {|piece| piece.board = self}
  end

  private

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
  end

  def pieces
    @rows.flatten.reject {|piece| piece == @null_piece}
  end

  def king_position(color)
    king = pieces.find do |piece|
      piece.color == color && piece.symbol == :K
    end

    king.position
  end

  def player_pieces(color)
    pieces.select {|piece| piece.color == color}
  end

  def opposing_pieces(color)
    pieces.reject {|piece| piece.color == color}
  end

end