require_relative './battle_maker'

RSpec.describe BattleMaker do
  subject { BattleMaker.load_strategy("robot_1") }

  it "makes a battle" do
    battle = BattleMaker::make(
      [
        "_____",
        "_____",
        "0_x_1",
        "_____",
        "__2__"
      ],
      {
        0 => { rotation: 0 },
        1 => { rotation: 180 }
      }
    )

    # Board is right size
    expect(battle.board.width).to eq(5)
    expect(battle.board.height).to eq(5)

    # Robots get right position and override rotation
    expect(battle.robots[0].rotation).to eq(0)
    expect(battle.robots[0].x).to eq(0)
    expect(battle.robots[0].y).to eq(2)

    expect(battle.robots[1].rotation).to eq(180)
    expect(battle.robots[1].x).to eq(4)
    expect(battle.robots[1].y).to eq(2)

    expect(battle.robots[2].rotation).to eq(0)
    expect(battle.robots[2].x).to eq(2)
    expect(battle.robots[2].y).to eq(0)

    # Walls show up
    expect(battle.board.walls.length).to be(1)
    expect(battle.board.walls[0].x).to be(2)
    expect(battle.board.walls[0].y).to be(2)
  end

end