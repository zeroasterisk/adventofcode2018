defmodule Mix.Tasks.Sleepy2 do
  @moduledoc false

  use Mix.Task

  @shortdoc "sleepy 1, adventofcode2018, most asleep guard+min"
  def run(argv \\ ["./input.txt"]) do
    guard = argv
            |> List.first()
            |> File.stream!()
            |> Enum.reduce(%Guards{}, &Sleepy.apply_log_line/2)
            |> Map.get(:guards)
            |> Map.values()
            |> Enum.map(&Sleepy.calc_guard/1)
            |> Enum.filter(fn(%Guard{highest_min: h}) -> !is_nil(h) end)
            |> Enum.sort_by(fn(%Guard{highest_min: {_min, count}}) -> count end)
            |> List.last() # get the most asleep guard

    guard_id = guard |> Map.get(:id)

    {min, count} = guard |> Map.get(:highest_min)

    IO.puts("Guard #{guard_id} was most asleep in min #{min} with product #{guard_id * min}")
  end
end
