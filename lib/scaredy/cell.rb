require 'strategy/constants'
require 'strategy/models'

module Scaredy
  class Cell
    include Strategy::Model::Target

    def initialize(x, y)
      @x = x
      @y = y
    end
  end
end
