module Reversi
  class Player
    def move( board, color )
      print "#{color}'s turn, your move:"
      Position.new(*(gets.chomp.split(',').map(&:to_i)))
    end
  end
end
