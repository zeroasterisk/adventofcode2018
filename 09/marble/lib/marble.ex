defmodule Marble do
  @moduledoc """
  Documentation for Marble.
  """
  # import Marble.Helper
  require Logger

  @doc """
  main do stuff

  ## Examples

      # iex> Marble.main(:p1)
      # 386018

      # iex> Marble.main(:p2)
      # :TODO

  """
  def main(:p1) do
    Marble.high_score_for_players_until(476, 71657)
  end
  def main(:p2) do
    # TOO BIG
    # Marble.high_score_for_players_until(476, 7165700)
  end
  def main(arg) do
    Logger.info "invoked main(#{inspect(arg)})"
    arg
  end

  @doc """

    # iex> Marble.high_score_for_players_until(9, 25)
    # 32

    # iex> Marble.high_score_for_players_until(10, 1618)
    # 8317
    #
    # iex> Marble.high_score_for_players_until(13, 7999)
    # 146373

  """
  def high_score_for_players_until(players, last_play) do
    players
    |> Marble.init()
    |> Marble.play_until(last_play)
    |> Map.get(:scores)
    |> Map.values()
    |> Enum.sort()
    |> List.last()
  end

  @doc """
  play until the "last play" is complete
  - player_turn = next player
  - player_turn = next player

  iex> Marble.init(9) |> Marble.play_until(15)
  %{
    circle: [0, 8, 4, 9, 2, 10, 5, 11, 1, 12, 6, 13, 3, 14, 7, 15],
    last_played_index: 15,
    play: 15,
    player_turn: 6,
    players: 9,
    scores: %{}
  }

  iex> Marble.init(9) |> Marble.play_until(25)
  %{
    circle: [0, 16, 8, 17, 4, 18, 19, 2, 24, 20, 25, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
    last_played_index: 10,
    play: 25,
    player_turn: 7,
    players: 9,
    scores: %{"5" => 32}
  }
  """
  def play_until(acc, last_play) do
    acc = acc |> update()
    case acc.play >= last_play do
      true -> acc
      false -> acc |> next_turn() |> play_until(last_play)
    end
  end

  def init(players) do
    %{
      circle: [0, 1],
      last_played_index: 1,
      players: players,
      player_turn: 2,
      play: 2,
      scores: %{},
    }
  end


  def update(acc) do
    acc
    |> play_marble()
    |> score()
  end

  @doc """
  Updates the circle and last_played_index (places the marble)

  ## Examples

      iex> Marble.play_marble(%{circle: [0], last_played_index: 0, play: 1})
      %{circle: [0, 1], last_played_index: 1, play: 1}

      iex> Marble.play_marble(%{circle: [0, 1], last_played_index: 1, play: 2})
      %{circle: [0, 2, 1], last_played_index: 1, play: 2}

      iex> Marble.play_marble(%{circle: [0, 2, 1], last_played_index: 1, play: 3})
      %{circle: [0, 2, 1, 3], last_played_index: 3, play: 3}

      iex> Marble.play_marble(%{circle: [0, 2, 1, 3], last_played_index: 3, play: 4})
      %{circle: [0, 4, 2, 1, 3], last_played_index: 1, play: 4}

  """
  def play_marble(), do: :nope
  def play_marble(true), do: :yep
  def play_marble(%{circle: [0], last_played_index: 0} = acc) do
    acc |> Map.merge(%{circle: [0, 1], last_played_index: 1})
  end
  def play_marble(%{circle: [0, 1], last_played_index: 1} = acc) do
    acc |> Map.merge(%{circle: [0, 2, 1], last_played_index: 1})
  end
  def play_marble(%{circle: circle, last_played_index: last_played_index, play: play} = acc) do
    case Integer.mod(play, 23) do
      0 -> acc # skip play, will score
      _ ->
        # Logger.info "invoked play_marble(#{inspect(acc)})"
        insert_at_index = next_index(last_played_index, Enum.count(circle))
        acc |> Map.merge(%{
          last_played_index: insert_at_index,
          circle: List.insert_at(circle, insert_at_index, play),
        })
    end
  end

  @doc """
  If multiple of 23
  - Updates score
  - Also adjusts marbles/index
  Else, nothing

  ## Examples

    iex> Marble.score(%{circle: [0, 2, 1], last_played_index: 1, play: 3, player_turn: 3, scores: %{}})
    %{circle: [0, 2, 1], last_played_index: 1, play: 3, player_turn: 3, scores: %{}}

    iex> %{
    ...>   circle: [0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
    ...>   last_played_index: 13,
    ...>   player_turn: 5,
    ...>   play: 23,
    ...>   scores: %{},
    ...> } |> Marble.play_marble() |> Marble.score()
    %{
      circle: [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
      scores: %{"5" => 32},
      last_played_index: 6, player_turn: 5, play: 23,
    }

  """
  def score(%{circle: circle, last_played_index: last_played_index, player_turn: player_turn, play: play, scores: scores} = acc) do
    case Integer.mod(play, 23) do
      0 ->
        # Logger.info "scoring during turn #{inspect(acc)}"
        player_scoring = Integer.to_string(player_turn)
        pluck_index = less_7_index(last_played_index, Enum.count(circle))
        {plucked, circle} = List.pop_at(circle, pluck_index)
        new_score = play + plucked + Map.get(scores, player_scoring, 0)
        acc |> Map.merge(%{
          scores: Map.put(scores, player_scoring, new_score),
          circle: circle,
          last_played_index: pluck_index,
        })
      _ -> acc
    end
  end

  @doc """
  Updates play and player_turn (cycle to the next turn)

  ## Examples

    iex> Marble.next_turn(%{player_turn: 1, play: 1, players: 9})
    %{player_turn: 2, play: 2, players: 9}
    iex> Marble.next_turn(%{player_turn: 9, play: 1, players: 9})
    %{player_turn: 2, play: 2, players: 9}

  """
  def next_turn(%{play: play, players: players} = acc) do
    # Logger.info "invoked play_marble(#{inspect(acc)})"
    play = play + 1
    acc |> Map.merge(%{
      play: play,
      player_turn: next_player_turn(play, players)
    })
  end

  @doc """
  iex> Marble.next_player_turn(1, 9)
  1
  iex> Marble.next_player_turn(9, 9)
  9
  iex> Marble.next_player_turn(10, 9)
  1
  iex> Marble.next_player_turn(11, 9)
  2
  iex> Marble.next_player_turn(90, 9)
  9
  iex> Marble.next_player_turn(91, 9)
  1
  """
  def next_player_turn(play, players) do
    player_turn = Integer.mod(play, players)
    # round = Integer.floor_div(play, players)
    next_player_turn(play, players, player_turn)
  end
  def next_player_turn(_play, players, 0) do
    players
  end
  def next_player_turn(_play, _players, mod) do
    mod
  end


  @doc """
  iex> Marble.next_index(0, 1)
  1
  iex> Marble.next_index(1, 2)
  1
  iex> Marble.next_index(1, 3)
  3
  iex> Marble.next_index(3, 4)
  1
  iex> Marble.next_index(1, 5)
  3
  iex> Marble.next_index(3, 6)
  5
  iex> Marble.next_index(5, 7)
  7
  iex> Marble.next_index(5, 7)
  7

  """
  def next_index(last_played_index, length) do
    case last_played_index + 2 > length do
      true -> 1
      false -> last_played_index + 2
    end
  end


  @doc """
  iex> Marble.less_7_index(13, 22)
  6
  iex> Marble.less_7_index(1, 64) # 69, less 6... since we didn't add 23-1, nor 46-1, nor 69
  58

  """
  def less_7_index(last_played_index, length) do
    case last_played_index - 7 < 0 do
      true ->
        # IO.puts("less_7_index rolled to end @ #{length}")
        length - 7 + last_played_index
      false -> last_played_index - 7
    end
  end

  @doc """
  Function does...

  ## Examples

      iex> Marble.func_template(:todo)
      :todo

      iex> Marble.func_template(:more)
      :more

  """
  def func_template(nil), do: :nope
  def func_template(true), do: :yep
  def func_template(arg) do
    # Logger.info "invoked func_template(#{inspect(arg)}) (no skip)"
    arg
  end


end
