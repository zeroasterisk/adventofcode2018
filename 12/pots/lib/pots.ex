
defmodule Pots do
  @moduledoc """
  Documentation for Pots.
  """
  # import Pots.Helper
  require Logger

  @doc """
  main do stuff

  ## Examples

      # iex> Pots.main(:p1)
      # 3059
      #
      # iex> Pots.main(:p2)
      # :TODO

  """
  def main(:p1) do
    String.duplicate(".", 50) <> init_state() <> String.duplicate(".", 500)
    |> run_generations(0, 23)
    |> sum_plants(-51)
  end
  def main(:p2) do
    gen_499 = String.duplicate(".", 50) <> init_state() <> String.duplicate(".", 500) |> run_generations(0, 500)
    gen_500 = gen_499 |> next_state()
    sum_499 = gen_499 |> sum_plants(-51)
    sum_500 = gen_500 |> sum_plants(-51)
    delta = sum_500 - sum_499
    sum_500 + (delta * (50_000_000 - 500))
  end
  def main(arg) do
    Logger.info "invoked main(#{inspect(arg)})"
    arg
  end

  # from input
  def init_state do
    "######....##.###.#..#####...#.#.....#..#.#.##......###.#..##..#..##..#.##..#####.#.......#.....##.."
  end

  # rule from input
  def rule(str) do
    case str do
      "...##" -> "#"
      "###.." -> "."
      "#.#.#" -> "."
      "#####" -> "."
      "....#" -> "."
      "##.##" -> "."
      "##.#." -> "#"
      "##..." -> "#"
      "#..#." -> "#"
      "#.#.." -> "."
      "#.##." -> "."
      "....." -> "."
      "##..#" -> "."
      "#..##" -> "."
      ".##.#" -> "#"
      "..###" -> "#"
      "..#.#" -> "#"
      ".####" -> "#"
      ".##.." -> "."
      ".#..#" -> "#"
      "..##." -> "."
      "#...." -> "."
      "#...#" -> "."
      ".###." -> "."
      "..#.." -> "."
      "####." -> "#"
      ".#.##" -> "."
      "###.#" -> "."
      "#.###" -> "#"
      ".#..." -> "#"
      ".#.#." -> "."
      "...#." -> "."
      _ -> "."
    end
  end

  @doc """
  Sum of potted indexes (adjusted for left padding)

  ## Examples

      iex> Pots.sum_plants(".#....##....#####...#######....#.#..##.", -3)
      325

      iex> Pots.sum_plants("........##.##.##.#..##.#......#...#..#.#..##.#..##.#..##.#.....#...#..#.#..##.#..##.#..##.#...#..#..##.#..##.#..##.#..##.#..##.#......", -11)
      3059

      iex> Pots.sum_plants("............................##.##.##.#..##.#......#...#..#.#..##.#..##.#..##.#.....#...#..#.#..##.#..##.#..##.#...#..#..##.#..##.#..##.#..##.#..##.#......", -31)
      3059
  """
  def sum_plants(str, adjust \\ 0) do
    str
    |> String.split("", trim: true)
    |> Stream.with_index(adjust)
    |> Enum.filter(fn({k, _v}) -> k == "#" end)
    |> Enum.map(fn({_k, v}) -> v end)
    |> IO.inspect()
    |> Enum.sum()
  end

  @doc """
  Run each generation until done

  ## Examples

      iex> Pots.run_generations("#..#.#..##......###...###", 0, 2)
      "##...#.#...#..#...##...#."
  """
  def run_generations(str, i, n) when i == n, do: str
  def run_generations(str, i, n) do
    next = str |> next_state()
    # IO.puts("run_generations #{i} = #{sum_plants(next, -51)} --- #{next}")
    next |> run_generations(i + 1, n)
  end

  @doc """
  Apply rule to generate next state

  ## Examples

      iex> Pots.next_state("#..#.#..##......###...###")
      ".###..#...#....##..#.##.."
  """
  def next_state(str) do
    str
    |> chunk_state()
    |> Enum.reduce([], fn(chunk, next) -> [(chunk |> rule()) | next] end)
    |> Enum.reverse()
    |> Enum.join()
  end

  @doc """
  Consume state into chunks

  ## Examples

      iex> Pots.chunk_state("#..#.#..##......###...###")
      ["..#..", ".#..#", "#..#.", "..#.#", ".#.#.", "#.#..", ".#..#",
       "#..##", "..##.", ".##..", "##...", "#....", ".....", ".....",
       "....#", "...##", "..###", ".###.", "###..", "##...", "#...#",
       "...##", "..###", ".###.", "###.."]

  """
  def chunk_state(str) do
    chunk_state(
      str,
      %{
        i: 0,
        len: String.length(str),
        chunks: [],
      }
    ) |> Enum.reverse()
  end
  def chunk_state(_str, %{i: i, len: len, chunks: chunks}) when i == len, do: chunks
  def chunk_state(str, %{i: i, len: len, chunks: chunks}) do
    chunk_state(str, %{i: i + 1, len: len, chunks: [get_chunk(str, i, len) | chunks]})
  end

  @doc """
  Consume state into a chunk

  ## Examples

      iex> Pots.get_chunk("#..#.#..##......###...###", 0, 25)
      "..#.."
      iex> Pots.get_chunk("#..#.#..##......###...###", 1, 25)
      ".#..#"
      iex> Pots.get_chunk("#..#.#..##......###...###", 2, 25)
      "#..#."
      iex> Pots.get_chunk("#..#.#..##......###...###", 3, 25)
      "..#.#"
      iex> Pots.get_chunk("#..#.#..##......###...###", 22, 25)
      "..###"
      iex> Pots.get_chunk("#..#.#..##......###...###", 23, 25)
      ".###."
      iex> Pots.get_chunk("#..#.#..##......###...###", 24, 25)
      "###.."

  """
  def get_chunk(str, 0, _len), do: ".." <> String.slice(str, 0, 3)
  def get_chunk(str, 1, _len), do: "." <> String.slice(str, 0, 4)
  def get_chunk(str, i, len) when i == len - 1, do: String.slice(str, i - 2, 3) <> ".."
  def get_chunk(str, i, len) when i == len - 2, do: String.slice(str, i - 2, 4) <> "."
  def get_chunk(str, i, _len), do: String.slice(str, i - 2, 5)


end
