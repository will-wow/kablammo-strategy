require './examples/aggressive'
require 'scaredy/danger_matrix'
require 'scaredy/danger_moves'

extend Aggressive
include Scaredy

@opponents = {}
@turn = 0

on_turn do
  turn()
end

def turn
  record_opponents()

  # Calculate danger score from currently visible opponents.
  danger_matrix = DangerMatrix.score(
    battle.board, me, opponents
  )

  # Danger score of current cell.
  current_danger = danger_matrix.at(me.x, me.y)

  # Best move to escape danger.
  moves = DangerMoves.best_moves(me, danger_matrix)
  move_to_safety = first_possible_move(moves)

  # A visible enemy that we're aiming at.
  target = enemy_in_sights(opponents)
  # A remembered enemy that we're aiming at.
  far_target = enemy_in_sights(known_opponents)

  return move_to_safety unless known_opponents.any?

  # Always dodge an aimed enemy.
  return move_to_safety if DangerScore.immediate_danger?(current_danger)

  # Fire if not in immediate danger
  return fire_at! target if target && !empty?

  # Run if you can't shoot
  return move_to_safety if DangerScore.seen?(current_danger)

  # Aim at the last know location of an opponent, if safe
  return aim_at! known_opponents.first unless far_target

  "." if !me.ammo_full?

  # Random walk
  move_to_safety
end

def record_opponents
  @turn += 1

  # Update last seen players
  opponents.each do |opponent|
    @opponents[opponent.username] = {
      last_seen: @turn,
      opponent: opponent
    }
  end

  # Clean up dead players
  dead_players.each do |dead|
    @opponents.delete(dead.username)
  end
end

def known_opponents
  @opponents
    .values
    .sort_by { |data| data[:last_seen] }
    .reverse
    .map { |data| data[:opponent] }
end

def enemy_in_sights(opponents)
  opponents.find { |opponent| i.can_fire_at?(opponent) }
end

def empty?
  me.ammo <= 0
end