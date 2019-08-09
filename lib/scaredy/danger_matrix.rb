require 'matrix'

require 'strategy/constants'
require 'strategy/constants'
require_relative './cell'
require_relative './danger_score'

module Scaredy
  class DangerMatrix
    include Strategy::Constants

    attr_accessor :matrix

    def self.score(board, me, opponents)
      danger_matrix = DangerMatrix.new()
      danger_matrix.score_cells(me, board, opponents)
      danger_matrix
    end

    def self.from_array(array)
      danger_matrix = DangerMatrix.new()
      matrix = Matrix[*array]

      danger_matrix.matrix = matrix
      danger_matrix
    end

    def at(x, y)
      return nil if x < 0
      return nil if y < 0
      @matrix[y, x]
    end

    def safe?(x, y) 
      at(x, y) == 0
    end

    def score_cells(me, board, opponents)
      @matrix = map_cells(board.width, board.height) do |cell|
        Scaredy::DangerScore.score(cell, me, opponents)
      end
    end

    private

    def map_cells(width, height, &block)
      Matrix.build(width, height) do |y, x|
        cell = Cell.new(x, y)
        value = block.call(cell)
      end
    end
  end
end