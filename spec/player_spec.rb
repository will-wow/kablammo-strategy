require_relative '../lib/kablammo'

RSpec.describe Player do
  subject { Player.load_strategy("user") }

  def make_battle(
    width: 5,
    height: 5,
    walls: [{x: 2, y: 2}],
    robots:
  )
    default_robot =  {
      username: "robot_1",
      last_turn: "*",
      x: 0,
      y: 0,
      armor: 5,
      ammo: 10,
      rotation: 0,
      direction: 0,
      abilities: [],
      power_ups: []
    }

    Strategy::Model::Battle.new(
      turn: {
        board: {
          width: width,
          height: height,
          walls: walls,
          robots: robots.map { |robot| robot.merge(default_robot)} ,
          power_ups: []
        }
      }
    )
  end

  let(:battle) do
    make_battle(robots: [
      { username: "robot_1", x: 0, y: 0, },
      { username: "robot_2", x: 4, y: 4, }
    ])
  end

  it "works" do
    expect(subject.execute_turn(battle)).to eq("f")
  end 
end
