module Reversi
  class Greeder
    def move( board, color )
      puts "#{color}'s move, thinking..."
      valid_moves = board.valid_moves( color )
      valid_moves.max_by do |move| 
	board.pieces_to_flip( move, color ).length
      end
    end
  end
end
