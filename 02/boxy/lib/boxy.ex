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
end
