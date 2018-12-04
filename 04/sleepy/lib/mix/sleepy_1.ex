defmodule Mix.Tasks.Sleepy1 do
  @moduledoc false

  use Mix.Task

  @shortdoc "sleepy 1, adventofcode2018, most asleep guard+min"
  def run(argv \\ ["./input.txt"]) do
    guards = argv
            |> List.first()
            |> File.stream!()
            |> Enum.reduce(%Guards{}, &Sleepy.apply_log_line/2)
            |> Map.get(:guards)
            |> Map.values()
            |> Enum.map(&Sleepy.calc_guard/1)
            |> Enum.sort_by(fn(%Guard{total_asleep: n}) -> n end)

    # IO.puts("debug: [guard = min]")
    # guards
    # |> Enum.map(fn(%Guard{id: id, total_asleep: t}) -> "G##{id} = #{t}" end)
    # |> IO.inspect()

    guard = guards |> List.last() # get the most asleep guard

    # IO.puts("debug: [min = count]")
    # guard
    # |> Map.get(:sleep_mins)
    # |> Enum.sort_by(fn({_k, v}) -> v end)
    # |> Enum.map(fn({min, count}) -> "#{min} = #{count}" end)
    # |> IO.inspect()
    #
    # IO.inspect(guard)

    guard_id = guard |> Map.get(:id)

    {min, count} = guard
          |> Map.get(:sleep_mins)
          |> Enum.sort_by(fn({_k, v}) -> v end)
          |> List.last() # get the most asleep min


    IO.puts("Guard #{guard_id} was most asleep in min #{min} with product #{guard_id * min}")
  end
end
