# Reversi in Ruby

We built a command-line version of the classic game of Reversi (aka Othello) using Ruby.
To use it, simply type `ruby reversi.rb`.

## Add your AI player and player with it

Implement a class with instance method "move", which return a Reversi::Position object showing its move.
And change the Player or Greeder class( or both ) to your class in reversi.rb

```ruby
if __FILE__ == $PROGRAM_NAME
  include Reversi
  Game.new(Player.new, Greeder.new).start
end
```

You can use all method in all class if you want, like `valid_move` and `pieces_to_flip`. ( They are useful! )
Check Greeder class if you need an example.
