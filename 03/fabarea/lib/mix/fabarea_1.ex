defmodule Mix.Tasks.Fabarea1 do
  @moduledoc false

  use Mix.Task

  @shortdoc "fabarea, adventofcode2018, count of all >1 nodes in fabric"
  def run(_argv) do
    "./input.txt"
    |> File.stream!()
    |> Enum.reduce(Matrix.new(1000, 1000), &Fabarea.apply_claim/2)
    # |> IO.inspect()
    |> List.flatten()
    |> Enum.reduce(0, &count_multiclaim/2)
    |> IO.inspect()
  end
  def count_multiclaim(0, acc), do: acc
  def count_multiclaim(1, acc), do: acc
  def count_multiclaim(_x, acc), do: acc + 1
end
