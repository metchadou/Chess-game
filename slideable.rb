require "byebug"

module Slideable
  HORIZONTAL_DIRS = [[0,1], [0,-1]]
  VERTICAL_DIRS = [[1, 0], [-1, 0]]
  DIAGONAL_DIRS = [[1,1], [1,-1], [-1,-1], [-1,1]]

  def moves
    move_dirs
  end

  def move_dirs
  end

  def horizontal_dirs
    moves = []

    HORIZONTAL_DIRS.each do |dir|
      dx, dy = dir
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end

    moves
  end

  def vertical_dirs
    moves = []

    VERTICAL_DIRS.each do |dir|
      dx, dy = dir
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end

    moves
  end

  def diagonal_dirs
    moves = []

    DIAGONAL_DIRS.each do |dir|
      dx, dy = dir
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end

    moves
  end

  private

  def grow_unblocked_moves_in_dir(dx, dy)
    unblocked_moves = []
    # Keep track of previous moves to check if a previous move
    # has captured a piece in which case the piece cannot move further
    prev_pos = self.position
    next_pos = [prev_pos[0] + dx, prev_pos[1] + dy]

    # Shovel all moves that are not blocked by a piece of the same color
    # or by the capture a piece of the opponent
    until !self.board.in_board?(next_pos) || blocked_move?(next_pos, prev_pos)
      unblocked_moves << next_pos

      prev_pos = next_pos
      next_pos = [prev_pos[0] + dx, prev_pos[1] + dy]
    end

    unblocked_moves
  end

  def blocked_move?(current_pos, prev_pos)
    piece = self.board[current_pos]
    
    # A piece cannot move to a position where a piece of the same color is placed.
    #  Also, a piece cannot move further after capturing a piece
    (!piece.empty? && piece.color == self.color) || captured_piece?(prev_pos)
  end

  def captured_piece?(prev_pos)
    piece = self.board[prev_pos]

    # If a piece is not a null piece (empty) and and is not
    # the same color as self piece, it is captured.
    # The self piece cannot move/slide further.
    !piece.empty? && piece.color != self.color
  end
end