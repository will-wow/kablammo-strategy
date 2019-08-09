require_relative './cell'
require_relative '../strategy/constants'

module Scaredy
  class DangerScore
    include Strategy::Constants

    TARGETED = 10
    SEEN = 1
    SAFE = 0

    def self.score(cell, me, opponents)
      score = opponents.reduce(0) do |count, opponent|
         count + danger_score(cell, opponent)
      end

      score - aim_score(cell, me)
    end

    def self.danger_score(cell, opponent)
      return TARGETED if opponent.located_at?(cell)
      return SAFE if hidden_from?(opponent, cell)

      return TARGETED if opponent.can_fire_at?(cell)
      return SEEN
    end

    def self.aim_score(cell, me)
      me.can_fire_at?(cell) ? 1 : 0
    end

    def self.immediate_danger?(score)
      score >= TARGETED
    end

    def self.seen?(score)
      score >= SEEN
    end

    def self.hidden_from?(opponent, cell)
      return false if opponent.located_at? cell

      los = opponent.line_of_sight_to cell
      return false if los.empty?

      first_barrier = los.index do |pixel|
        opponent.board.fixed_obstruction?(pixel)
      end

      return false unless first_barrier

      target_hit = los.index { |p| p.located_at? cell }
      # Return true if the target is behind the barrier
      target_hit > first_barrier
    end

    def self.wall?(opponent, pixel)
      opponent.board.walls.any? { |w| w.located_at? target }
    end
  end
end