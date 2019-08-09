require 'matrix'

require_relative '../battle_maker'
require_relative '../../lib/scaredy/danger_matrix'

RSpec.describe Scaredy::DangerMatrix do
  let(:map) do 
    [
      "     ",
      "     ",
      "0 x 1",
      "     ",
      "  2  "
    ]
  end

  let(:battle) do
    BattleMaker.make(map, robot_data)
  end

  let(:me) { battle.robots[0] }
  let(:opponents) { battle.robots[1..-1] }

  subject { Scaredy::DangerMatrix.score(battle.board, me, opponents) }

  context "given a robot pointing west" do
    let(:robot_data) { {
      0 => { rotation:  90 },
      2 => { rotation: 180 },
    } }

    it "records a danger cone" do
      expected_scores = [
        [ 0,  0,  0,  0,  1],
        [ 0,  1,  0,  1,  1],
        [ 1,  1,  1,  1,  1],
        [ 1,  1,  1,  1,  1],
        [10, 10, 10,  1,  1],
      ].reverse

      expect(subject.matrix).to eq(Matrix[*expected_scores])
    end
  end

  context "given a robot pointing west" do
    let(:map) do 
      [
        "     ",
        "     ",
        "0   1",
        "     ",
        "  2  "
      ]
    end

    let(:robot_data) { {
      1 => { rotation: 180 },
      2 => { rotation: 90 }
    } }

    it "records overlapping danger cones" do
      expected_scores = [
        [2,   2, 11,  2,  2],
        [2,   2, 11,  2,  2],
        [11, 10, 19, 10, 10],
        [2,   2, 11,  2,  2],
        [2,   2, 11,  2,  2],
      ].reverse

      expect(subject.matrix).to eq(Matrix[*expected_scores])
    end
  end
end