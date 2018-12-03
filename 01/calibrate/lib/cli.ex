defmodule Calibrate.CLI do
  @moduledoc """
  Calibrate can be used as command line utility:
  ./calibrate "input.txt"
  """
  def main(args \\ []) when is_list(args) do
    args
    |> Enum.map(&Calibrate.CLI.main_lines/1)
    |> Enum.join("\n")
  end
  def main_lines(path) when is_bitstring(path) do
    total = path
    |> File.stream!()
    |> Enum.reduce(0, &Calibrate.clean_and_sum/2)
    "#{total} <-- [#{path}]"
  end
end
