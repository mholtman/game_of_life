defmodule GameOfLifeTest do
  use ExUnit.Case

  alias GameOfLife.World

  test "an empty world returns an empty world" do
    assert MapSet.new == World.step(MapSet.new)
  end

  test "a world with a single live cell returns an empty world" do
    world = [{0, 0}] |> MapSet.new
    assert World.step(world) == MapSet.new
  end

  test "a cell can find its neighbors" do
    expected = [
      {-1,-1}, {0,-1}, {1, -1},
      {-1, 0},         {1, 0},
      {-1, 1}, {0, 1}, {1, 1}
    ] |> MapSet.new

    assert World.neighbors({0,0}) == expected
  end

  test "a cell can count live neighbors" do
    world = [
      {-1, -1},     {1, -1},
              {0, 0},
                    {1, 1}
    ] |> MapSet.new

    assert World.live_neighbors_count({0, 0}, world) == 3
  end

  test "a cell with three live neighbors survives" do
    world = [
      {-1, -1},     {1, -1},
              {0, 0},
                    {1, 1}
    ] |> MapSet.new

    assert World.step(world)
    |> MapSet.member?({0, 0})
  end

  test "a cell with two live neighbors survives" do
    world = [
      {-1, -1},     {1, -1},
              {0, 0}
    ] |> MapSet.new

    assert World.step(world)
    |> MapSet.member?({0, 0})
  end

  test "a neighboring cell with exactly 3 neighbors comes to life" do
    world = [
      {-1, -1},     {1, -1},
             # {0, 0} will come to life...
                    {1, 1}
    ] |> MapSet.new

    expected = [{0, 0}] |> MapSet.new

    assert World.step(world) == expected
  end
end
