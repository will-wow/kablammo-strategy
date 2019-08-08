require_relative '../lib/kablammo'
require_relative './battle_maker'

require 'pry'

RSpec.describe Player do
  subject { Player.load_strategy("robot_0") }

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

  it "rests by default" do
    expect(subject.execute_turn(battle)).to eq(".")
  end 

  context "" do
    let(:map) do 
      [
        "_____",
        "_____",
        "0___1",
        "_____",
        "_____"
      ]
    end
  end
  it "moves away from a threatening opponent" do
    let
  end

  describe "#threats?" do
    context "given an opponent facing away" do
      it "is not threatened" do
        subject.execute_turn(battle)
        expect(subject.threats?()).to eq(false)
      end
    end

    context "given an opponent facing me" do
      let(:robots_data) do 
        { 1 => { rotation: 180 } }
      end
      
      it "is threatened" do
        subject.execute_turn(battle)
        expect(subject.threats?()).to eq(true)
      end
    end
  end
end
