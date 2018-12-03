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
    # version 1
    # total = path
    # |> File.stream!()
    # |> Enum.reduce(0, &Calibrate.clean_and_sum/2)
    # |> output(path)
    # version 2
    path
    |> File.stream!()
    |> Enum.reduce(0, &Calibrate.clean_and_sum_and_identify_dupes/2)
    |> output(path)
  end
  def output({total, list, nil}, path) do
    # well, we don't allow this, we re-reun the input again, until the duplicates exist
    path
    |> File.stream!()
    |> Enum.reduce({total, list, nil}, &Calibrate.clean_and_sum_and_identify_dupes/2)
    |> output(path)
  end
  def output({total, _list, first_dupe}, path) do
    "final total #{total} [first duplicated sum: #{first_dupe}] <-- [#{path}]"
  end
  # def output(total, path) do
  #   "#{total} [v1 no duplicated lookup] <-- [#{path}]"
  # end
end
