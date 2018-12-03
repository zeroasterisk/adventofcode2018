defmodule Mix.Tasks.Calibrate do
  @moduledoc false

  use Mix.Task

  @shortdoc "calibrate, adventofcode2018, sum a file of digits"
  def run(argv) do
    Calibrate.CLI.main(argv) |> IO.inspect()
  end
end
