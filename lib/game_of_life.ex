defmodule GameOfLife do

  alias GameOfLife.World, as: World

  defdelegate step(world), to: World

end
