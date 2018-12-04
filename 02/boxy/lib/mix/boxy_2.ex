defmodule Mix.Tasks.Boxy2 do
  @moduledoc false

  use Mix.Task

  @shortdoc "boxy 1, adventofcode2018, find 2 ids 1 char apart, return their :eq parts"
  def run(argv \\ ["./input.txt"]) do
    %{found: found} = argv
                  |> List.first()
                  |> File.stream!()
                  |> Enum.sort()
                  |> Enum.map(&String.trim/1)
                  |> Enum.reduce(%{last: nil, found: nil}, &Boxy.compare_id/2)

    IO.puts("Found #{found}")
  end
end
