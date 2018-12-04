defmodule Boxy do
  @moduledoc """
  Documentation for Boxy.
  """

  @doc """
  convert a string to a freq count per letter

  ## Examples

      iex> Boxy.freq_count("abcdef")
      %{"a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1}

      iex> Boxy.freq_count("bababc")
      %{"a" => 2, "b" => 3, "c" => 1}

  """
  def freq_count(str) do
    str
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn(l, acc) -> acc |> Map.update(l, 1, &(&1 + 1)) end)
  end

  @doc """
  does a freq_count for a string have X letter counts

  ## Examples

      iex> Boxy.has_freq_count?(Boxy.freq_count("abcdef"), 2)
      false

      iex> Boxy.has_freq_count?(Boxy.freq_count("bababc"), 2)
      true

      iex> Boxy.has_freq_count?(Boxy.freq_count("bababc"), 3)
      true

      iex> Boxy.has_freq_count?(Boxy.freq_count("bababc"), 4)
      false

  """
  def has_freq_count?(%{} = f, n) do
    f |> Map.values() |> Enum.member?(n)
  end

  @doc """
  compare 2 strings, and allow no more than 1 char difference between the two

  ## Examples

      iex> Boxy.compare_id("fghij", %{last: "fguij", found: nil})
      %{found: "fgij", last: "fghij"}

      iex> Boxy.compare_id("abcdef", %{last: "fguij", found: nil})
      %{found: nil, last: "abcdef"}

      iex> Boxy.compare_id("abcdef", %{last: "aaaa", found: "aaaa"})
      %{last: "aaaa", found: "aaaa"}

  """
  def compare_id(str, %{last: nil, found: nil}) do
    %{last: str, found: nil}
  end
  def compare_id(str, %{last: last, found: nil} = acc) do
    diff = String.myers_difference(str, last)
    case is_compare_id_good?(diff) do
      true ->
        found = diff
                |> Enum.filter(fn({k, _}) -> k === :eq end)
                |> Keyword.values()
                |> Enum.join()
        acc |> Map.merge(%{last: str, found: found})
      false ->
        acc |> Map.merge(%{last: str, found: nil})
    end
  end
  def compare_id(_str, %{found: _found} = acc), do: acc

  @doc """
  Is within 1 char?

  ## Examples

      iex> Boxy.is_compare_id_good?(String.myers_difference("fghij", "fguij"))
      true

      iex> Boxy.is_compare_id_good?(String.myers_difference("abcdef", "fguij"))
      false
  """
  def is_compare_id_good?(diff) do
    diff = diff |> Enum.filter(fn({k, _}) -> k !== :eq end)
    [
      diff |> Enum.count() == 2,
      diff |> Keyword.keys() |> Enum.sort() == [:del, :ins],
      diff |> Keyword.values() |> Enum.map(&String.length/1) == [1, 1],
    ] |> Enum.all?()
  end
end
