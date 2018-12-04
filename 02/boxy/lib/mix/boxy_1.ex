defmodule Mix.Tasks.Boxy1 do
  @moduledoc false

  use Mix.Task

  @shortdoc "boxy 1, adventofcode2018, checksum 1 * 2"
  def run(argv \\ ["./input.txt"]) do
    freq_counts = argv
                  |> List.first()
                  |> File.stream!()
                  |> Enum.map(&Boxy.freq_count/1)

    # IO.inspect(freq_counts)

    x2 = freq_counts |> Enum.filter(fn(fc) -> fc |> Boxy.has_freq_count?(2) end) |> Enum.count()
    x3 = freq_counts |> Enum.filter(fn(fc) -> fc |> Boxy.has_freq_count?(3) end) |> Enum.count()

    IO.puts("Found #{x2} w/ 2 & #{x3} w/ 3")
    IO.puts("#{x2} * #{x3} = #{x2 * x3}")
  end
end
