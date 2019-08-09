require 'matrix'

require 'scaredy/danger_matrix'
require 'scaredy/cell'
require 'scaredy/danger_moves'

RSpec.describe Scaredy::DangerMoves do
  context "given a danger matrix" do
    let(:danger_matrix) do
      Scaredy::DangerMatrix.from_array([
        [2, 4, 0],
        [0, 1, 3],
        [3, 2, 0],
      ].reverse)
    end

    it "moves toward safety" do
      me = Scaredy::Cell.new(1, 1) 

      expect(Scaredy::DangerMoves.best_moves(me, danger_matrix)).to eq(["w", ".", "s", "e", "n"])
    end

    it "won't move off the map" do
      me = Scaredy::Cell.new(0, 1) 

      expect(Scaredy::DangerMoves.best_moves(me, danger_matrix)).to eq([".", "e", "n", "s"])
    end
  end
end