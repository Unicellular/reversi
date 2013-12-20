require_relative 'game'
require_relative 'position'
require_relative 'board'
require_relative 'player'
require_relative 'greeder'

if __FILE__ == $PROGRAM_NAME
  include Reversi
  Game.new(Player.new, Greeder.new).start
end
