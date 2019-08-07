require './examples/aggressive'
require './examples/defensive'

extend Aggressive
extend Defensive

@last_move = nil

on_turn do
  binding.pry
  move = first_possible_move("#{@last_move}nesw")
  @last_move = move
  move
end
