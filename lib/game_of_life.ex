defmodule GameOfLife do

  def step(world) do
    MapSet.union(survivors(world), births(world))
  end

  defp survivors(world) do
    world
    |> MapSet.to_list
    |> Stream.map(fn ({x, y}) -> {x, y, live_neighbors_count({x, y}, world)} end)
    |> Stream.filter(&alive?/1)
    |> MapSet.new(fn ({x, y, _}) -> {x, y} end)
  end

  defp alive?({_x, _y, neighbors}) do
    neighbors > 1 and neighbors < 4
  end

  defp new_birth?({_x, _y, neighbors}) do
    neighbors == 3
  end

  defp births(world) do
    world
    |> MapSet.to_list
    |> Stream.map(&neighbors/1)
    |> Enum.reduce(MapSet.new, &MapSet.union/2)
    |> MapSet.difference(world)
    |> MapSet.to_list
    |> Stream.map(fn ({x, y}) -> {x, y, live_neighbors_count({x, y}, world)} end)
    |> Enum.filter(&new_birth?/1)
    |> MapSet.new(fn ({x, y, _}) -> {x, y} end)
  end

  def neighbors({x, y}) do
    for delta_x <- [-1, 0, 1], delta_y <- [-1, 0, 1] do
      {x + delta_x, y + delta_y}
    end
    |> MapSet.new
    |> MapSet.delete({x,y})
  end

  def live_neighbors_count(cell, world) do
    cell
    |> neighbors()
    |> MapSet.intersection(world)
    |> MapSet.size
  end

end
