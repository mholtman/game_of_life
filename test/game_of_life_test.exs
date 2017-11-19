defmodule GameOfLifeTest do
  use ExUnit.Case

  test "an empty world returns an empty world" do
    assert MapSet.new == GameOfLife.step(MapSet.new)
  end
end
