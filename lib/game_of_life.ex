defmodule GameOfLife do

  def step(world) do
    world
    |> MapSet.to_list
    |> Stream.map(fn ({x, y}) -> {x, y, live_neighbors_count({x, y}, world)} end)
    |> Stream.filter(fn ({x, y, neighbors}) -> neighbors > 1 and neighbors < 4 end)
    |> Stream.map(fn ({x, y, _}) -> {x, y} end)
    |> MapSet.new
  end

  def neighbors({x, y}) do
    for delta_x <- [-1, 0, 1], delta_y <- [-1, 0, 1] do
      {x + delta_x, y + delta_y}
    end
    |> MapSet.new
    |> MapSet.difference(MapSet.new([{x,y}]))
  end

  def live_neighbors_count(cell, world) do
    neighbors(cell)
    |> MapSet.intersection(world)
    |> MapSet.size
  end

end
