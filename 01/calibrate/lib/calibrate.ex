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

  @doc """
  Clean and then sum a "line" onto an accumulator.
  Maintain a list (MapSet) of all prior sums, with which we can determine if we've already seen a sum.
  Maintain a single "first duplicate sum".

  Our accumulator now looks like this: `{sum, prior_sums, first_dupe}`

  ## Examples

      iex> Calibrate.clean_and_sum_and_identify_dupes("-1", 0)
      {-1, MapSet.new([-1]), nil}

      iex> Calibrate.clean_and_sum_and_identify_dupes("-3", {-1, MapSet.new([-1]), nil})
      {-4, MapSet.new([-4, -1]), nil}

      iex> Calibrate.clean_and_sum_and_identify_dupes("-3", {-4, MapSet.new([-4, -1]), nil})
      {-7, MapSet.new([-7, -4, -1]), nil}

      iex> Calibrate.clean_and_sum_and_identify_dupes("+3", {-7, MapSet.new([-7, -4, -1]), nil})
      {-4, MapSet.new([-7, -4, -1]), -4}

      iex> Calibrate.clean_and_sum_and_identify_dupes("+3", {-4, MapSet.new([-7, -4, -1]), -4})
      {-1, MapSet.new([-7, -4, -1]), -4}

  """
  def clean_and_sum_and_identify_dupes(line, acc) when is_bitstring(line) and is_integer(acc) do
    # allow simple 0 as acc to get us started
    clean_and_sum_and_identify_dupes(line, {acc, MapSet.new(), nil})
  end
  def clean_and_sum_and_identify_dupes(line, {acc, prior_sums, first_dupe}) when is_bitstring(line) and is_integer(acc) and is_map(prior_sums) do
    sum = line |> Calibrate.clean_line |> Calibrate.sum(acc)
    has_prior = MapSet.member?(prior_sums, sum)
    prior_sums = MapSet.put(prior_sums, sum)
    # we are going to identify_dupes and return that 3 item tuple as our accumulator
    identify_dupes(sum, prior_sums, first_dupe, has_prior)
  end

  @doc """
  Identify duplicated sums, only caring about the first duplicate found

  This is kinda just cleanup, the work is done above,
  but this is a handy way of organizing our results piggybacking on pattern matcing.

  Our response is the new accumulator shape of: `{sum, prior_sums, first_dupe}`

  ## Examples

      iex> Calibrate.identify_dupes(3, MapSet.new([1, 3]), nil, true)
      {3, MapSet.new([1, 3]), 3}

      iex> Calibrate.identify_dupes(3, MapSet.new([1, 3]), nil, false)
      {3, MapSet.new([1, 3]), nil}

      iex> Calibrate.identify_dupes(3, MapSet.new([1, 3]), 1, true)
      {3, MapSet.new([1, 3]), 1}

  """
  def identify_dupes(sum, prior_sums, first_dupe, false = _has_prior) do
    # have not seen this sum before... maintain
    {sum, prior_sums, first_dupe}
  end
  def identify_dupes(sum, prior_sums, nil = _first_dupe, true = _has_prior) do
    # since we have seen this before, and we don't yet have a first_dupe, we set sum as first_dupe
    {sum, prior_sums, sum}
  end
  def identify_dupes(sum, prior_sums, first_dupe, true = _has_prior) do
    # we have seen this before, but we do already have a first_dupe, we keep first_dupe
    {sum, prior_sums, first_dupe}
  end

end
