require 'rspec'
require_relative '../reversi'

include Reversi

describe Greeder do
  let(:greeder) { Greeder.new }
  let(:pieces) do
    {
      white: [[2, 4], [3, 4], [4, 4], [5, 4], [3, 3]].map do |cood|
        Position.new( cood )
      end,
      black: [[4, 3], [4, 5]].map do |cood|
        Position.new( cood )
      end
    }
  end
  let(:board) { Board.new }

  describe "#move should return most greedy action" do
    before do
      [:white, :black].each do |color|
        pieces[color].each do |pos|
          board[pos] = color
        end
      end
    end

    it { greeder.move( board, :black ).should eq( Position.new( 2, 3 ) ) }
  end
end
