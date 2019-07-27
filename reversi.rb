require_relative 'game'
require_relative 'position'
require_relative 'board'
require_relative 'player'
require_relative 'greeder'
require_relative 'qlearner'

if __FILE__ == $PROGRAM_NAME
  include Reversi
  Game.new(Player.new, Qlearner.new(:black)).start
end
