module Reversi
  class Board
    SIZE = 8
    CENTER = [SIZE / 2 - 1, SIZE / 2]
    INIT_PIECE = {
      white: [Reversi::Position.new(CENTER[0], CENTER[0]), Reversi::Position.new(CENTER[1], CENTER[1])],
      black: [Reversi::Position.new(CENTER[0], CENTER[1]), Reversi::Position.new(CENTER[1], CENTER[0])]
    }
    DIRECTIONS = [
      [-1, 0],
      [-1, 1],
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1]
    ]
    def initialize
    end

    def reset
      @content = Array.new(SIZE){ Array.new(SIZE){ nil } }
      INIT_PIECE.each do |color, positions|
          positions.each do |pos|
          self[pos] = color
        end
      end
      self
    end

    def []=( pos, color )
      @content[pos.row][pos.col] = color
    end

    def []( pos )
      @content[pos.row][pos.col]
    end

    def result
      return nil unless [:white, :black].none? { |color| has_move? color }
      black, white = count_piece
      case black <=> white
        when 1
          :black
        when -1
          :white
        else
          :draw
      end
    end

    def count_piece
      black = 0
      white = 0
      @content.flatten.each do |pos|
        next if pos.nil?

        black += 1 if pos == :black
        white += 1 if pos == :white
      end
      return black, white
    end

    def has_move?( color )
      (0...SIZE).any? do |i|
        (0...SIZE).any? do |j|
          valid?( Position.new( i, j ), color )
        end
      end
    end

    def valid_moves( color )
      (0...SIZE).map do |i|
        (0...SIZE).map do |j|
          pos = Position.new( i, j )
          pos if valid?( pos, color )
        end
      end.flatten.compact
    end

    def valid?( pos, color )
      return false if out_of_bounds?( pos )
      return false unless self[pos].nil?

      pieces_to_flip( pos, color ).any?
    end

    def pieces_to_flip( pos, color )
      DIRECTIONS.map do |dir|
        pieces_to_flip_dir( pos, color, dir )
      end.flatten
    end

    def pieces_to_flip_dir( pos, color, dir )
      current_pos = pos + dir
      result = []
      loop do
        if out_of_bounds?( current_pos )
          return []
        elsif self[current_pos].nil?
          return []
        elsif self[current_pos] == color
          return result
        else
          result.push current_pos
        end
        current_pos += dir
      end
    end

    def out_of_bounds?( pos )
      pos.row > SIZE-1 || pos.row < 0 || pos.col > SIZE-1 || pos.col < 0
    end

    def flip!( piece )
      self[piece] = ( self[piece] == :white ) ? :black : :white
    end

    def flip_neighbor( pos, color )
      pieces_to_flip( pos, color ).each do |piece|
        flip! piece
      end
    end

    def show( color )
      pic = {
        white: "O",
        black: "X",
        possible: "*"
      }
      pic.default = "."
      possible = valid_moves( color )
      possible.each{ |pos| self[pos] = :possible }
      puts ' ' * 2 +  (0...SIZE).to_a.join(' ')
      @content.each_with_index do |row,i|
        puts row.map{ |grid| pic[grid] }.unshift(i).join(' ')
      end
      possible.each{ |pos| self[pos] = nil if self[pos] == :possible }
    end

    def count( color )
      @content.flatten.count{ |piece| piece == color }
    end

    def content
      trans_piece = {
        white: 1,
        black: -1
      }
      trans_piece.default = 0
      @content.map do |row|
        row.map do |piece|
          trans_piece[piece]
        end
      end
    end
  end
end
