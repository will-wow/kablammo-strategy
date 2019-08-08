require_relative '../battle_maker'
require_relative '../../lib/safety/danger_score'

RSpec.describe Safety::DangerScore do
  let(:map) do 
    [
      "     ",
      "     ",
      "0 x 1",
      "     ",
      "     "
    ]
  end

  let(:robot_data) { {} }

  let(:battle) do
    BattleMaker.make(map, robot_data)
  end

  it "works" do
    Safety::SafetyScore.score_cell({x: 0, y: 0}, battle)
  end
end