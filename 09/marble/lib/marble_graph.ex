
defmodule MarbleGraph do
  @moduledoc """
  Marble - reimplemented as a Cyclic Graph
  (immutable data has burned me at scale)
  """
  # import Marble.Helper
  require Logger
  alias Graph.Edge

  @doc """
  # iex> MarbleGraph.main(9, 7) |> Map.delete(:g)
  # %{
  #   player_count: 9,
  #   current: 7,
  #   max: 7,
  #   # g: #Graph<type: directed, vertices: [1, 3, 4, 2, 0], edges: [1 -> 3, 3 -> 4, 4 -> 0, 2 -> 1, 0 -> 2]>,
  #   players: %{}
  # }
  #
  # iex> MarbleGraph.main(9, 22) |> Map.delete(:g)
  # %{
  #   player_count: 9,
  #   current: 22,
  #   max: 22,
  #   # g: #Graph<type: directed, vertices: [1, 3, 4, 2, 0], edges: [1 -> 3, 3 -> 4, 4 -> 0, 2 -> 1, 0 -> 2]>,
  #   players: %{}
  # }
  #
  # iex> MarbleGraph.main(9, 23) |> Map.delete(:g)
  # %{
  #   player_count: 9,
  #   current: 19,
  #   max: 23,
  #   # g: #Graph<type: directed, vertices: [1, 3, 4, 2, 0], edges: [1 -> 3, 3 -> 4, 4 -> 0, 2 -> 1, 0 -> 2]>,
  #   players: %{"5" => 32}
  # }
  #
  # iex> MarbleGraph.main(9, 23) |> MarbleGraph.return_high_score()
  # 32

  # iex> MarbleGraph.main(13, 7999) |> MarbleGraph.return_high_score()
  # 146373
  # iex> MarbleGraph.main(13, 799900) |> MarbleGraph.return_high_score()
  # 0

  """
  def main(player_count, max) do
    %{
      players: %{},
      player_count: player_count,
      max: max,
      g: Graph.new(type: :directed)
         |> Graph.add_edges([
           Edge.new(0, 2),
           Edge.new(2, 1),
           Edge.new(1, 3),
           Edge.new(3, 0),
         ]),
      current: 3,
    }
    # |> IO.inspect()
    |> play(4)
  end

  def play(%{max: max} = acc, play_n) when play_n > max, do: acc
  def play(%{} = acc, play_n) do
    case Integer.mod(play_n, 23) do
      # scoring round, do crazy stuff
      0 -> acc |> play_score(play_n)
      # normal round, insert new marble after current + 2
      _ -> acc |> play_after(play_n)
    end
    # |> IO.inspect()
    |> play(play_n + 1)
  end

  def play_score(%{g: g, current: current, players: players, player_count: player_count} = acc, play_n) do
    player_key = play_n |> Integer.mod(player_count) |> Integer.to_string()
    between_start = get_before(acc.g, current, 8)
    capture = get_before(acc.g, current, 7)
    between_stop = get_before(acc.g, current, 6)
    # IO.puts("score #{play_n} & capture #{capture} between #{between_start} & #{between_stop}")
    # update graph/circle
    g = g
        |> Graph.delete_vertex(capture)
        |> Graph.add_edge(between_start, between_stop)
    # update score
    player_score = players |> Map.get(player_key, 0)
    player_score = Enum.sum([player_score, capture, play_n])
    players = players |> Map.put(player_key, player_score)
    # return updated
    acc
    |> Map.put(:g, g)
    |> Map.put(:current, between_stop)
    |> Map.put(:players, players)
  end

  def play_after(%{g: g, current: current} = acc, play_n) do
    between_start = get_after(g, current, 1)
    between_stop = get_after(g, current, 2)
    # IO.puts("play #{play_n} between #{between_start} & #{between_stop}")
    acc
    |> Map.put(:g, g |> Graph.split_edge(between_start, between_stop, play_n))
    |> Map.put(:current, play_n)
  end

  def get_after(_g, n, 0), do: n
  def get_after(g, n, until) do
    [%Graph.Edge{label: nil, v1: nx, v2: target, weight: 1} | more_edges] = g |> Graph.out_edges(n)
    if (!Enum.empty?(more_edges)) do
      Logger.warn("get_after #{n} returned #{nx} -> #{target} and more edges: #{inspect(more_edges)}")
    end
    if (n != nx) do
      Logger.warn("get_after #{n} returned #{nx} -> #{target}")
    end
    get_after(g, target, until - 1)
  end

  def get_before(_g, n, 0), do: n
  def get_before(g, n, until) do
    [%Graph.Edge{label: nil, v1: target, v2: nx, weight: 1} | more_edges] = g |> Graph.in_edges(n)
    if (!Enum.empty?(more_edges)) do
      Logger.warn("get_before #{n} returned #{target} -> #{nx} and more edges: #{inspect(more_edges)}")
    end
    if (n != nx) do
      Logger.warn("get_before #{n} returned #{target} -> #{nx}")
    end
    get_before(g, target, until - 1)
  end

  def return_high_score(%{players: players}) do
    players
    |> Map.values()
    |> Enum.sort()
    |> List.last()
  end

 # [%Graph.Edge{label: nil, v1: 44741, v2: 8364, weight: 1}, %Graph.Edge{label: nil, v1: 44741, v2: 14572, weight: 1}]"
end

