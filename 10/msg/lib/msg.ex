
defmodule Pnt do
  defstruct [
    x: 0,
    y: 0,
    vx: 0,
    vy: 0,
  ]
end
defmodule Msg do
  @moduledoc """
  Documentation for Msg.
  """
  # import Msg.Helper
  require Logger

  @doc """
  main do stuff

  ## Examples

      iex> Msg.main(:p1_test)
      "done"

      iex> Msg.main(:p1)
      "done"

  """
  def main(:p1) do
    Msg.Helper.get_input()
    |> loop_until(1, 20000)
  end
  def main(:p1_test) do
    Msg.Helper.get_test()
    |> loop_until(1, 5)
  end

  @doc """
  Quick and dirty loop iterator
  """
  def loop_until(list, n, max) when n == max, do: "done"
  def loop_until(list, n, max) do
    list
    |> Enum.map(&tick/1) |> print(n)
    |> loop_until(n + 1, max)
  end

  @doc """
  Emit to stdout a "human readable" scope of the board as it stands now
  skip doing so if the range of x & y is too large
  """
  def print(points, n) do
    min_x = points |> Enum.min_by(fn(%Pnt{x: x}) -> x end) |> Map.get(:x)
    min_y = points |> Enum.min_by(fn(%Pnt{y: y}) -> y end) |> Map.get(:y)
    max_x = points |> Enum.max_by(fn(%Pnt{x: x}) -> x end) |> Map.get(:x)
    max_y = points |> Enum.max_by(fn(%Pnt{y: y}) -> y end) |> Map.get(:y)
    # shuffle to easy lookup
    point_map = Enum.reduce(points, %{}, fn(%Pnt{x: x, y: y}, acc) -> acc |> Map.put({x, y}, "#") end)
    # print & plot
    case (abs(min_y) + abs(max_y) > 300 || abs(min_x) + abs(max_x) > 400) do
      true ->
        IO.puts("#{n}: skipping #{min_x}, #{min_y} --> #{max_x}, #{max_y}")
      false ->
        IO.puts("#{n}: printing #{min_x}, #{min_y} --> #{max_x}, #{max_y}")
        for y <- Range.new(min_y, max_y), x <- Range.new(min_x, max_x)  do
          IO.write(point_map |> Map.get({x, y}, " "))
          if x == max_x do
            IO.puts("")
          end
        end
    end
    points
  end


  @doc """
  Tick forward 1 second

  ## Examples

      iex> Msg.tick(%Pnt{x: 3, y: 9, vx: 1, vy: -2})
      %Pnt{x: 4, y: 7, vx: 1, vy: -2}

      iex> %Pnt{x: 3, y: 9, vx: 1, vy: -2} |> Msg.tick() |> Msg.tick()
      %Pnt{x: 5, y: 5, vx: 1, vy: -2}

      iex> %Pnt{x: 3, y: 9, vx: 1, vy: -2} |> Msg.tick() |> Msg.tick() |> Msg.tick()
      %Pnt{x: 6, y: 3, vx: 1, vy: -2}

  """
  def tick(%Pnt{x: x, y: y, vx: vx, vy: vy}) do
    %Pnt{x: x + vx, y: y + vy, vx: vx, vy: vy}
  end

end
