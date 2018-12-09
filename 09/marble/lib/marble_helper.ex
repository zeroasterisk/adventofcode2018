defmodule Marble.Helper do
  @moduledoc """
    Helpers for Marble.
  """
  # require Logger

  @input "whatever"


  @doc """
  quick and simple @input grabber
  """
  def get_test(10), do: %{players: 10, points: 1618, high: 8317}
  # 10 players; last marble is worth 1618 points: high score is 8317
  def get_test(13), do: %{players: 13, points: 7999, high: 146373}
# 13 players; last marble is worth 7999 points: high score is 146373
  def get_test(17), do: %{players: 17, points: 1104, high: 2764}
# 17 players; last marble is worth 1104 points: high score is 2764
  def get_test(21), do: %{players: 21, points: 6111, high: 54718}
# 21 players; last marble is worth 6111 points: high score is 54718
  def get_test(30), do: %{players: 30, points: 5807, high: 37305}
# 30 players; last marble is worth 5807 points: high score is 37305

  @doc """
  quick and simple @input grabber
  """
  def get_input, do: %{players: 476, points: 71657}
  # "476 players; last marble is worth 71657 points"

  @doc """
  quick and simple obtain a stream from an input file path
  """
  def get_file_stream(path), do: path |> File.stream!()

  @doc """
  a-z alphabet
  """
  def letters, do: ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
"q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

  @doc """
  convert a string to a freq count per letter

  ## Examples

      iex> Marble.Helper.string_freq_count("abcdef")
      %{"a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1}

      iex> Marble.Helper.string_freq_count("bababc")
      %{"a" => 2, "b" => 3, "c" => 1}

  """
  def string_freq_count(str) do
    str
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, fn(l, acc) -> acc |> Map.update(l, 1, &(&1 + 1)) end)
  end

  @doc """
  Does a Map have a Value as a Member?

  ## Examples

      iex> Marble.Helper.map_value_member?(Marble.Helper.string_freq_count("abcdef"), 2)
      false

      iex> Marble.Helper.map_value_member?(Marble.Helper.string_freq_count("bababc"), 2)
      true

      iex> Marble.Helper.map_value_member?(Marble.Helper.string_freq_count("bababc"), 3)
      true

      iex> Marble.Helper.map_value_member?(Marble.Helper.string_freq_count("bababc"), 4)
      false

  """
  def map_value_member?(%{} = f, n) do
    f |> Map.values() |> Enum.member?(n)
  end

  @doc """
  build grid and assign {x, y} points

  ## Examples

      iex> Marble.Helper.grid(5) |> List.last()
      %{x: 4, y: 4}

      iex> Marble.Helper.grid(5) |> List.first()
      %{x: 0, y: 0}

      iex> Marble.Helper.grid(5, %{id: :custom}) |> List.last()
      %{id: :custom, x: 4, y: 4}

  """
  def grid(len \\ 10, src \\ %{}) do
    len = len - 1
    for x <- 0..len, y <- 0..len do
      src |> Map.merge(%{x: x, y: y})
    end
  end

end
