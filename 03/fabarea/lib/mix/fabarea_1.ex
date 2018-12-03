defmodule Mix.Tasks.Fabarea1 do
  @moduledoc false

  use Mix.Task

  @shortdoc "fabarea, adventofcode2018, count of all >1 nodes in fabric"
  def run(argv \\ ["./input.txt"]) do
    argv
    |> List.first()
    |> File.stream!()
    |> Enum.reduce(%{}, &Fabarea.apply_claim/2)
    # |> IO.inspect()
    |> Map.values() |> Enum.filter(fn(n) -> n > 1 end) |> Enum.count()
    |> IO.inspect()
  end
end
