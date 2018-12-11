defmodule Mix.Tasks.Fuel do
  @moduledoc """
  Mix Task Main entrypoint for Fuel.

  Usage:
  $ mix fuel
  $ mix fuel arg1 arg2
  """
  use Mix.Task

  @shortdoc "mix task..."
  def run(argv \\ []) do
    argv |> Enum.each(&run_per_arg/1)
    IO.puts("...done")
  end

  @shortdoc "mix task for each arg..."
  def run_per_arg(arg \\ :default) do
    IO.puts("Executing main(#{inspect(arg)})")
    output = Fuel.main(arg)
    IO.puts("#{inspect(output)}")
  end
end
