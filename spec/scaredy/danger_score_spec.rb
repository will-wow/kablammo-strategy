require_relative '../battle_maker'
require_relative '../../lib/scaredy/danger_score'

RSpec.describe Scaredy::DangerScore do
  let(:map) do 
    [
      "     ",
      "     ",
      "0 x 1",
      "     ",
      "     "
    ]
  end

  let(:battle) do
    BattleMaker.make(map, robot_data)
  end

  let(:me) { battle.robots[0] }

  context "given a robot pointing west" do
    let(:robot_data) { {
      1 => { rotation: 180 }
    } }

    it "records a danger cone" do
      scores = Scaredy::DangerScore.score_cells(me, battle)

      expect(scores.reverse).to eq([
        [0, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0],
      ])
    end
  end

  context "given a robot pointing west" do
    let(:map) do 
      [
        "     ",
        "     ",
        "0 x 1",
        "     ",
        "  2  "
      ]
    end

    let(:robot_data) { {
      1 => { rotation: 180 },
      2 => { rotation: 90 }
    } }

    it "records overlapping danger cones" do
      scores = Scaredy::DangerScore.score_cells(me, battle)

      expect(scores.reverse).to eq([
        [0, 1, 1, 1, 0],
        [1, 2, 1, 1, 0],
        [1, 1, 2, 1, 0],
        [1, 1, 1, 0, 0],
        [0, 0, 0, 0, 0],
      ])
    end
  end
end