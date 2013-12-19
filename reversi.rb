require_relative 'game'
require_relative 'position'
require_relative 'board'
require_relative 'player'

if __FILE__ == $PROGRAM_NAME
  include Reversi
  Game.new(Player.new, Player.new).start
end
