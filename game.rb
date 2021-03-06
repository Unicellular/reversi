module Reversi
  class Game
    def initialize( player1, player2 )
      @board = Board.new
      @players = { white: player1, black: player2 }
      @current_color = :black
    end

    def start
      @board.reset
      until end?
        change_player
        next unless @board.has_move? @current_color
        #show_situation
        begin
          move = current_player.move( @board, @current_color )
        end until @board.valid?( move, @current_color )
        place_piece( move, @current_color )
      end
      #show_situation
      #puts "winner is #{@board.result}"
      @board.result
    end

    private
      def current_player
        @players[@current_color]
      end

      def change_player
        @current_color = (@current_color == :black) ? :white : :black
      end

      def end?
        !(@board.result.nil?)
      end

      def place_piece( pos, color )
        @board[pos] = color
        @board.flip_neighbor( pos, color )
      end

      def show_situation
        @board.show( @current_color )
        [:white, :black].each do |color|
          puts "#{color}: #{@board.count(color)}"
        end
      end
  end
end
