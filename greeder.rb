module Reversi
  class Greeder
    def move( board, color )
      valid_moves = board.valid_moves( color )
      result = valid_moves.max_by do |move| 
	board.pieces_to_flip( move, color ).length
      end
      puts "#{color}'s turn, thinking...#{result.row},#{result.col}" 
      result
    end
  end
end
