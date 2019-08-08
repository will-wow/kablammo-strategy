require './examples/aggressive'
require './examples/defensive'
require_relative './lib/scaredy/danger_score'

extend Aggressive
extend Defensive

@last_move = nil
@opponents = {}

on_turn do
  turn()
end

def is_threat?(opponent)
  Scaredy::DangerScore.danger_zone?(me, opponent)
end

def threats?
  threats.any?
end

def threats
  opponents.filter(&method(:is_threat?))
end

def turn
  return move_away_from!(threats.first) if threats?
  return @last_move if @last_move
  "."
end
