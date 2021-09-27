require "byebug"
require_relative "board"
require_relative "display"
require_relative "human_player"

class Game
  
  attr_accessor :board
  attr_reader :display, :player1, :player2
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:black, @display)
    @player2 = HumanPlayer.new(:white, @display)
  end

  def play
    @current_player = @player1
    until @board.checkmate?(@current_player.color)
      begin
        @display.render
        notify_players
        @current_player.make_move(board)
      rescue EmptyPositionError => e
        puts e.message
        sleep(1.5)
        retry
      rescue MoveInCheckError => e
        puts e.message
        sleep(1.5)
        retry
      rescue ForbiddenMoveError => e
        puts e.message
        sleep(1.5)
        retry
      rescue MovingOpponentPieceError => e
        puts e.message
        sleep(1.5)
        retry
      end
      swap_turn
    end

    @display.render
    puts "#{@current_player.color.to_s.upcase} : échec et mat"
  end

  private

  def notify_players
    puts "It's #{@current_player.color.to_s.upcase} turn"
  end

  def swap_turn
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end