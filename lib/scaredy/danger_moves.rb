require 'strategy/constants'
require 'strategy/models'

module Scaredy
  class DangerMoves
    include Strategy::Constants

    def self.best_moves(me, danger_matrix)
      x = me.x
      y = me.y

      directions = {
        NORTH => danger_matrix.at(x, y + 1),
        EAST =>  danger_matrix.at(x + 1, y),
        SOUTH => danger_matrix.at(x, y - 1),
        WEST =>  danger_matrix.at(x - 1, y),
        "." => danger_matrix.at(x, y),
      }

      directions
        .to_a
        .reject { |direction, danger| danger.nil? }
        .shuffle
        .sort_by { |direction, danger| danger }
        .map { |direction, danger| direction }
    end
  end
end