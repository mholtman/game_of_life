defmodule GameOfLifeTest do
  use ExUnit.Case

  test "an empty world returns an empty world" do
    assert MapSet.new == GameOfLife.step(MapSet.new)
  end

  test "a world with a single live cell returns an empty world" do
    world = [{0,0}] |> MapSet.new
    assert MapSet.new == GameOfLife.step(world)
  end

  test "a cell can find its neighbors" do
    expected = [
      {-1,-1}, {0,-1}, {1, -1},
      {-1, 0},         {1, 0},
      {-1, 1}, {0, 1}, {1, 1}
    ] |> MapSet.new

    assert GameOfLife.neighbors({0,0}) == expected
  end
end
