defmodule Calibrate do
  @moduledoc """
  Documentation for Calibrate.
  """

  @doc """
  Transform "-1" into -1 and +333 into 333

  ## Examples

      iex> Calibrate.clean_line("-1")
      -1

      iex> Calibrate.clean_line("+333")
      333

  """
  #
  def clean_line(line) when is_bitstring(line), do: line |> Integer.parse |> clean_line
  def clean_line({number, _}) when is_integer(number), do: number
  def clean_line(number) when is_integer(number), do: number
  def clean_line(_), do: 0

  @doc """
  Accumulate/reduce a stream of numbers into a sum

  ## Examples

      iex> Calibrate.sum(0, 0)
      0

      iex> Calibrate.sum(-1, 2)
      1

      iex> Calibrate.sum(-3, 1)
      -2
  """
  def sum(element, acc) when is_integer(element), do: element + acc
  def sum(element, acc) do
    IO.puts "Error, unable to sum #{inspect(element)} and #{inspect(acc)}"
    acc
  end

  @doc """
  Clean and then sum a "line" onto an accumulator

  ## Examples

      iex> Calibrate.clean_and_sum("-1", 0)
      -1

  """
  def clean_and_sum(line, acc) when is_bitstring(line) and is_integer(acc) do
    line |> Calibrate.clean_line |> Calibrate.sum(acc)
  end

end
