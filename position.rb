module Reversi
  class Position
    attr_reader :row, :col

    def initialize(row, col = nil)
      if row.is_a? Array
        @row, @col = row[0], row[1]
      elsif col == nil
        @row, @col = row / Board::SIZE, row % Board::SIZE
      else
        @row, @col = row, col
      end
    end

    def +(dir)
      Position.new( @row + dir[0], @col + dir[1] )
    end

    def ==(other_pos)
      @row == other_pos.row && @col == other_pos.col
    end

    def count_index1d
      row * Board::SIZE + col
    end

    def to_s
      "#{@row},#{@col}"
    end
  end
end
