require_relative 'game'
require_relative 'position'
require_relative 'board'
require_relative 'player'
require_relative 'greeder'
require_relative 'qlearner'

if __FILE__ == $PROGRAM_NAME
  include Reversi
  greeder = Greeder.new
  qlearner = Qlearner.new( :black )
  game = Game.new( greeder, qlearner )
  stat = { white: 0, black: 0, draw: 0 }
  list = []
  10.times do |j|
    100.times do |i|
      result = game.start
      stat[result] += 1
      list.push result
    end
    puts stat
  end
end
