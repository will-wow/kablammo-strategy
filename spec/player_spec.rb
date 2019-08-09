require_relative '../lib/kablammo'
require_relative './battle_maker'

require 'pry'

RSpec.describe Player do
  subject { Player.load_strategy("robot_0") }

  let(:map) do 
    [
      "_____",
      "_____",
      "0_x_1",
      "_____",
      "_____"
    ]
  end

  let(:robot_data) do
    {
      1 => { rotation: 180 }
    } 
  end

  let(:battle) do
    BattleMaker.make(map, robot_data)
  end

  context "given no immediate threat" do
    it "moves towards turret by default" do
      expect(subject.execute_turn(battle)).to eq("e")
    end 
  end

  context "given a threat" do
    let(:map) do 
      [
        "_____",
        "_____",
        "0___1",
        "_____",
        "_____"
      ]
    end

    it "moves away from threat" do
      expect(["n", "s"]).to include(subject.execute_turn(battle))
    end
  end
end
