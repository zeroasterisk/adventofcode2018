defmodule Mix.Tasks.Sleepy1 do
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
            |> Enum.sort_by(fn(%Guard{total_asleep: n}) -> n end)
            |> List.last() # get the most asleep guard

    guard_id = guard |> Map.get(:id)

    {min, count} = guard
                   |> Map.get(:sleep_mins)
                   |> Enum.sort_by(fn({_k, v}) -> v end)
                   |> List.last() # get the most asleep min


    IO.puts("Guard #{guard_id} was most asleep in min #{min} with product #{guard_id * min}")
  end
end
