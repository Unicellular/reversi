module Reversi
  class Player
    def move( board, color )
      begin
        print "#{color}'s turn, your move:"
        input = gets.chomp.split(',').map(&:to_i)
        Position.new(*input)
      rescue
        puts "format: row, col"
        retry
      end 
    end
  end
end
