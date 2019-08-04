require 'rspec'
require_relative '../reversi'

include Reversi

describe Board do
  let(:board) { Board.new.reset }
  let(:valid_positions) { [
    Position.new( 2, 4 ),
    Position.new( 3, 5 ),
    Position.new( 4, 2 ),
    Position.new( 5, 3 )
  ] }
  let(:piece_to_flip) { board.piece_to_flip( pos24, :white ) }

  it "both color should have move" do
    [:white, :black].each do |color|
      expect(board.has_move?(color)).to be true
    end
  end

  it "valid postions should be valid for white" do
    valid_positions.each do |pos|
      expect(board.valid?(pos, :white)).to be true
    end
  end

  it "#valid_moves should return valid positions" do
    expect(board.valid_moves( :white )).to eq(valid_positions)
  end
end
