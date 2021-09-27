require "byebug"
require_relative "player"


class HumanPlayer < Player

  def initialize(color, display)
    super
  end

  def make_move(board)
    board.move_piece(@color, get_start_pos, get_end_pos)
  end

  def get_start_pos
    start_pos = nil

    while start_pos.nil?
      start_pos = @display.cursor.get_input
      @display.render
    end

    start_pos
  end

  def get_end_pos
    end_pos = nil

    while end_pos.nil?
      end_pos = @display.cursor.get_input
      @display.render
    end

    end_pos
  end

  
  
end