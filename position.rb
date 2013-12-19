module Reversi
  class Position
    attr_reader :row, :col

    def initialize(row, col)
      @row, @col = row, col
    end

    def +(dir)
      Position.new( @row + dir[0], @col + dir[1] )
    end

    def ==(other_pos)
      @row == other_pos.row && @col == other_pos.col
    end
  end
end
