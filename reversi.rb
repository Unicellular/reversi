require_relative 'game'
require_relative 'position'
require_relative 'board'
require_relative 'player'
require_relative 'greeder'
require_relative 'qlearner'

if __FILE__ == $PROGRAM_NAME
  nn_filename = ARGV[0]
  total_times = ARGV[1].to_i
  report_times = ARGV[2].to_i
  interval_times = total_times / report_times
  include Reversi
  greeder = Greeder.new
  qlearner = Qlearner.new( :black, nn_filename )
  game = Game.new( greeder, qlearner )
  stat = { white: 0, black: 0, draw: 0 }
  list = []
  report_times.times do |j|
    interval_times.times do |i|
      result = game.start
      stat[result] += 1
      list.push result
    end
    puts stat
  end
  qlearner.save_nn(nn_filename)
end
