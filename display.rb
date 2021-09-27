require "byebug"
require "colorize"
require_relative "board"
require_relative "cursor"

class Display

  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system('clear')
    generate_colorized_board.each do |row|
      puts row.join("")
    end
  end

  private

  def generate_colorized_board
    @board.rows.map.with_index do |row, i|
      row.map.with_index do |col, j|
        pos = [i, j]
        piece = @board[pos]
        colorize_piece(piece, pos)
      end
    end
  end

  def colorize_piece(piece, pos)
    i, j = pos
    if pos == @cursor.cursor_pos
      if @cursor.selected
        piece.to_s.light_white.on_light_red
      else
        piece.to_s.light_red.on_light_cyan
      end
    else
      if i.even?
        if j.even?
          piece.to_s.black.on_light_white
        else
          piece.to_s.black.on_green
        end
      else
        if j.even?
          piece.to_s.black.on_green
        else
          piece.to_s.black.on_light_white
        end
      end
    end
  end

end