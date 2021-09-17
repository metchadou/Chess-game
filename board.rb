require "byebug"
require_relative "piece"

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
    @rows[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @rows[row][col] = value
  end

  def place_pieces
    starting_ranks_indices = [0,1,6,7]

    (0...rows.length).each do |row|
      (0...rows.length).each do |col|
        pos = [row, col]
        if starting_ranks_indices.include?(row)
          add_piece(Piece.new, pos)
        else
          add_piece(nil, pos)
        end
      end
    end
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def move_piece(start_pos, end_pos)
    piece = self[start_pos]

    raise EmptyPositionError if piece.nil?
    raise ForbiddenMoveError if !self[end_pos].nil?

    self[start_pos] = nil
    self[end_pos] = piece
  end

end