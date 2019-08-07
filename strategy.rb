require './examples/aggressive'
require './examples/defensive'

extend Aggressive
extend Defensive


on_turn do
  p me
  p battle
  'f'
end
