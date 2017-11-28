defmodule GameOfLife.World do

  def step(world) do
    MapSet.union(survivors(world), births(world))
  end

  defp survivors(world) do
    world
    |> filter_to(&alive?/1, world)
  end

  defp alive?({_x, _y, neighbors}) do
    neighbors > 1 and neighbors < 4
  end

  defp births(world) do
    dead_neighbors(world)
    |> filter_to(&new_birth?/1, world)
  end

  defp filter_to(life, f, world) do
    with_neighbor_count = fn ({x, y}) -> {x, y, live_neighbors_count({x, y}, world)} end
    without_neighbor_count = fn ({x, y, _count}) -> {x, y} end

    life
    |> MapSet.to_list
    |> Stream.map(with_neighbor_count)
    |> Enum.filter(f)
    |> MapSet.new(without_neighbor_count)
  end

  defp new_birth?({_x, _y, neighbors}) do
    neighbors == 3
  end

  defp dead_neighbors(world) do
    world
    |> MapSet.to_list
    |> Stream.map(&neighbors/1)
    |> Enum.reduce(MapSet.new, &MapSet.union/2)
    |> MapSet.difference(world)
  end

  def neighbors({x, y}) do
    range = [-1, 0, 1]
    for delta_x <- range, delta_y <- range, !(delta_x == 0 and delta_y == 0) do
        {x + delta_x, y + delta_y}
    end
    |> MapSet.new
  end

  def live_neighbors_count(cell, world) do
    cell
    |> neighbors()
    |> MapSet.intersection(world)
    |> MapSet.size
  end

end
