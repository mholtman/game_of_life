defmodule GameOfLifeTest do
  use ExUnit.Case

  test "an empty world returns an empty world" do
    assert MapSet.new == GameOfLife.step(MapSet.new)
  end

  test "a world with a single live cell returns an empty world" do
    world = [{0,0}] |> MapSet.new
    assert GameOfLife.step(world) == MapSet.new
  end

  test "a cell can find its neighbors" do
    expected = [
      {-1,-1}, {0,-1}, {1, -1},
      {-1, 0},         {1, 0},
      {-1, 1}, {0, 1}, {1, 1}
    ] |> MapSet.new

    assert GameOfLife.neighbors({0,0}) == expected
  end

  test "a cell can count live neighbors" do
    world = [
      {-1, -1},     {1, -1},
              {0,0},
                    {1, 1}
    ] |> MapSet.new

    assert GameOfLife.live_neighbors_count({0,0}, world) == 3
  end

  test "a cell with three live neighbors survives" do
    world = [
      {-1, -1},     {1, -1},
              {0,0},
                    {1, 1}
    ] |> MapSet.new

    expected = [{0,0}] |> MapSet.new

    assert GameOfLife.step(world) == expected
  end
end
