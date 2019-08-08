module Safety
  class DangerScore
    def self.score_cell(me, cell, battle)
      each_cell_in_battle(battle) do |cell|
        count_opponents_aiming_towards_target(cell, battle)
      end
    end

    def self.each_cell_in_battle(battle, &block)
      each_cell(battle.board.width, battle.board.height, block)
    end

    def self.each_cell(width, height, &block)
      for x in 0...width do
        for y in 0...height do
          cell = Strategy::Model::Target.new
          cell.x = x
          cell.y = y

          block.call(cell)
        end
      end
    end

    def self.count_opponents_aiming_towards_target(cell, battle)
      opponents(battle).reduce(0) do |count, opponent|
        danger_zone?(target, opponent) ? count + 1 : count
      end
    end

    def self.danger_zone?(target, opponent)
      (opponent.rotation - opponent.direction_to(me)).abs <= MAX_SKEW * 2
    end

    def self.visible_players(battle)
      battle.robots.reject{|r| r.dead? }
    end

    def self.opponents(battle, me)
      visible_players(battle).reject{ |r| r == me }
    end
  end
end