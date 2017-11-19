defmodule GameOfLife do

  def step(world) do
    MapSet.new
  end

  def neighbors({x, y}) do
    for delta_x <- [-1, 0, 1], delta_y <- [-1, 0, 1] do
      {x + delta_x, y + delta_y}
    end
    |> MapSet.new
    |> MapSet.difference(MapSet.new([{x,y}]))
  end

end
