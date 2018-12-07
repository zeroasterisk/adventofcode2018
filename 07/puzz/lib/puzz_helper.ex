defmodule Puzz.Helper do
  @moduledoc """
    Helpers for Puzz.
  """
  # require Logger

  # JKXDEPFBUAEHO

  def get_input do
    [
      "Step J must be finished before step E can begin.",
      "Step X must be finished before step G can begin.",
      "Step D must be finished before step A can begin.",
      "Step K must be finished before step M can begin.",
      "Step P must be finished before step Z can begin.",
      "Step F must be finished before step O can begin.",
      "Step B must be finished before step I can begin.",
      "Step U must be finished before step W can begin.",
      "Step A must be finished before step R can begin.",
      "Step E must be finished before step R can begin.",
      "Step H must be finished before step C can begin.",
      "Step O must be finished before step S can begin.",
      "Step Q must be finished before step Y can begin.",
      "Step V must be finished before step W can begin.",
      "Step T must be finished before step N can begin.",
      "Step S must be finished before step I can begin.",
      "Step Y must be finished before step W can begin.",
      "Step Z must be finished before step C can begin.",
      "Step M must be finished before step L can begin.",
      "Step L must be finished before step W can begin.",
      "Step N must be finished before step I can begin.",
      "Step I must be finished before step G can begin.",
      "Step C must be finished before step G can begin.",
      "Step G must be finished before step R can begin.",
      "Step R must be finished before step W can begin.",
      "Step Z must be finished before step R can begin.",
      "Step Z must be finished before step N can begin.",
      "Step G must be finished before step W can begin.",
      "Step L must be finished before step G can begin.",
      "Step Y must be finished before step R can begin.",
      "Step P must be finished before step I can begin.",
      "Step C must be finished before step W can begin.",
      "Step T must be finished before step G can begin.",
      "Step T must be finished before step R can begin.",
      "Step V must be finished before step Z can begin.",
      "Step L must be finished before step C can begin.",
      "Step K must be finished before step I can begin.",
      "Step J must be finished before step I can begin.",
      "Step Q must be finished before step C can begin.",
      "Step F must be finished before step A can begin.",
      "Step H must be finished before step Y can begin.",
      "Step M must be finished before step N can begin.",
      "Step P must be finished before step H can begin.",
      "Step M must be finished before step C can begin.",
      "Step V must be finished before step Y can begin.",
      "Step O must be finished before step V can begin.",
      "Step O must be finished before step Q can begin.",
      "Step A must be finished before step G can begin.",
      "Step T must be finished before step Z can begin.",
      "Step K must be finished before step R can begin.",
      "Step H must be finished before step O can begin.",
      "Step O must be finished before step Y can begin.",
      "Step O must be finished before step C can begin.",
      "Step K must be finished before step P can begin.",
      "Step P must be finished before step F can begin.",
      "Step E must be finished before step M can begin.",
      "Step M must be finished before step I can begin.",
      "Step T must be finished before step W can begin.",
      "Step P must be finished before step L can begin.",
      "Step A must be finished before step O can begin.",
      "Step X must be finished before step V can begin.",
      "Step S must be finished before step G can begin.",
      "Step A must be finished before step Y can begin.",
      "Step J must be finished before step R can begin.",
      "Step K must be finished before step F can begin.",
      "Step J must be finished before step A can begin.",
      "Step P must be finished before step C can begin.",
      "Step E must be finished before step N can begin.",
      "Step F must be finished before step Y can begin.",
      "Step J must be finished before step D can begin.",
      "Step H must be finished before step Z can begin.",
      "Step U must be finished before step H can begin.",
      "Step J must be finished before step T can begin.",
      "Step V must be finished before step G can begin.",
      "Step Z must be finished before step I can begin.",
      "Step H must be finished before step W can begin.",
      "Step B must be finished before step R can begin.",
      "Step F must be finished before step B can begin.",
      "Step X must be finished before step C can begin.",
      "Step L must be finished before step R can begin.",
      "Step F must be finished before step U can begin.",
      "Step D must be finished before step N can begin.",
      "Step P must be finished before step O can begin.",
      "Step B must be finished before step O can begin.",
      "Step F must be finished before step C can begin.",
      "Step H must be finished before step L can begin.",
      "Step O must be finished before step N can begin.",
      "Step J must be finished before step Y can begin.",
      "Step H must be finished before step N can begin.",
      "Step O must be finished before step L can begin.",
      "Step I must be finished before step W can begin.",
      "Step J must be finished before step H can begin.",
      "Step D must be finished before step Z can begin.",
      "Step F must be finished before step W can begin.",
      "Step X must be finished before step W can begin.",
      "Step Y must be finished before step M can begin.",
      "Step T must be finished before step M can begin.",
      "Step U must be finished before step G can begin.",
      "Step L must be finished before step I can begin.",
      "Step N must be finished before step W can begin.",
      "Step E must be finished before step C can begin.",
    ] |> Enum.map(&parse/1)
  end


  def get_test do
    [
      "Step C must be finished before step A can begin.",
      "Step C must be finished before step F can begin.",
      "Step A must be finished before step B can begin.",
      "Step A must be finished before step D can begin.",
      "Step B must be finished before step E can begin.",
      "Step D must be finished before step E can begin.",
      "Step F must be finished before step E can begin.",
    ] |> Enum.map(&parse/1)
  end

  @doc """
  parse into tuple
  iex> Puzz.Helper.parse("Step D must be finished before step E can begin.")
  {"D", "E"}
  """
  def parse(str) do
    [p1, p2] = Regex.replace(~r/^.+ ([A-Z]{1}) .+ ([A-Z]{1}) .+$/, str, "\\1\\2")
               |> String.split("", trim: true)
    {p1, p2}
  end

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

      iex> Puzz.Helper.string_freq_count("abcdef")
      %{"a" => 1, "b" => 1, "c" => 1, "d" => 1, "e" => 1, "f" => 1}

      iex> Puzz.Helper.string_freq_count("bababc")
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

      iex> Puzz.Helper.map_value_member?(Puzz.Helper.string_freq_count("abcdef"), 2)
      false

      iex> Puzz.Helper.map_value_member?(Puzz.Helper.string_freq_count("bababc"), 2)
      true

      iex> Puzz.Helper.map_value_member?(Puzz.Helper.string_freq_count("bababc"), 3)
      true

      iex> Puzz.Helper.map_value_member?(Puzz.Helper.string_freq_count("bababc"), 4)
      false

  """
  def map_value_member?(%{} = f, n) do
    f |> Map.values() |> Enum.member?(n)
  end

  @doc """
  build grid and assign {x, y} points

  ## Examples

      iex> Puzz.Helper.grid(5) |> List.last()
      %{x: 4, y: 4}

      iex> Puzz.Helper.grid(5) |> List.first()
      %{x: 0, y: 0}

      iex> Puzz.Helper.grid(5, %{id: :custom}) |> List.last()
      %{id: :custom, x: 4, y: 4}

  """
  def grid(len \\ 10, src \\ %{}) do
    len = len - 1
    for x <- 0..len, y <- 0..len do
      src |> Map.merge(%{x: x, y: y})
    end
  end

end
