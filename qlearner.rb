require "ruby-fann"

module Reversi
  class Qlearner
    def initialize( color )
      @internal_nn = RubyFann::Standard.new( num_inputs: 64, hidden_neurons: [ 10 ], num_outputs: 64)
      @exploration = 0.5
      @learning = 0.7
      @discount = 0.7
      @color = color
    end

    def move( board, color )
      if @last_action.nil?
        @next_q = @internal_nn.run(board.content.flatten)
      else
        learn_form_result( board )
      end
      action_select( board, color )
    end

    def action_select( board, color )
      return nil unless @color == color
      valid_moves = board.valid_moves( color )
      if Random.rand > @exploration
        @last_action = valid_moves[Random.rand(valid_moves.length)]
      else
        actions_q = @internal_nn.run(board.content.flatten)
        @last_action = valid_moves.max_by do |pos|
          actions_q[pos.count_index1d]
        end
      end
      return @last_action
    end

    def learn_form_result( board )
      black, white = board.count_piece
      if board.result == nil
        reward = 0
      else
        if @color == :black
          reward = black - white
        else
          reward = white - black
        end
      end
      old_q = @next_q
      old_q_action = old_q[@last_action.count_index1d]
      @next_q = @internal_nn.run(board.content.flatten)
      max_next_q = @next_q.max
      max_next_pos = @next_q.find(max_next_q)
      new_q_action = ( 1 - @learning ) * old_q_action + @learning * ( reward + @discount * max_next_q )
      old_q[@last_action.count_index1d] = new_q_action
      @internal_nn.train( board.content.flatten, old_q )
      #puts "print_connections"
      #@internal_nn.print_connections
      #puts "print_parameters"
      #@internal_nn.print_parameters
    end
  end
end
