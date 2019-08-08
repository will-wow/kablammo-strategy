require_relative './cell'
require_relative '../strategy/constants'

module Scaredy
  class DangerScore
    include Strategy::Constants

    def initialize(me, battle)
      @me = me
      @battle = battle
    end

    def self.danger_zone?(target, opponent)
      (opponent.rotation - opponent.direction_to(target)).abs <= MAX_SKEW * 2
    end

    def self.score_cells(me, battle)
      danger_score = DangerScore.new(me, battle)

      danger_score.score_cells()
    end

    def score_cells
      map_cells_in_battle do |cell|
        count_opponents_aiming_towards_target(cell)
      end
    end

    private

    def map_cells_in_battle(&block)
      map_cells(@battle.board.width, @battle.board.height, &block)
    end

    def map_cells(width, height, &block)
      values = []

      for y in 0...height do
        values.push([])

        for x in 0...width do
          cell = Cell.new(x, y)
          value = block.call(cell)

          values[y].push(value)
        end
      end

      values
    end

    def count_opponents_aiming_towards_target(target)
      opponents.reduce(0) do |count, opponent|
        DangerScore.danger_zone?(target, opponent) ? count + 1 : count
      end
    end

    def visible_players
      @battle.robots.reject{|r| r.dead? }
    end

    def opponents
      visible_players.reject{ |r| r == @me }
    end
  end
end