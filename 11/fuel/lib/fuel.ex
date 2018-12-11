defmodule Fuel do
  @moduledoc """
  Documentation for Fuel.
  """
  # import Fuel.Helper
  require Logger

  @gsn 8561

  @doc """
  main do stuff

  ## Examples

      iex> Fuel.main(:p1)
      :TODO

      iex> Fuel.main(:p2)
      :TODO

  """
  def main(:p1) do
    grid = Fuel.grid()
    sums = grid |> Enum.reduce(%{}, fn({{x, y}, _v}, acc) ->
      sum = grid |> Fuel.sum_block({x, y}, 3)
      acc |> Map.put("#{x},#{y}", sum)
    end)
    |> Enum.sort_by(fn({_k, v}) -> v end)
    |> List.last()
  end
  def main(:p2) do
    answer = :TODO
    Logger.info "Here is P2 #{answer}"
    answer
  end
  def main(arg) do
    Logger.info "invoked main(#{inspect(arg)})"
    arg
  end

  @doc """
  sum of 3x3 block, starting at top-right

  iex> Fuel.grid() |> Fuel.sum_block({1, 1})
  -7

  iex> Fuel.grid(18) |> Fuel.sum_block({33, 45})
  29
  """
  def sum_block(grid, {x, y}, n \\ 3) do
    for xn <- 0..(n - 1), yn <- 0..(n - 1) do
      # IO.puts("#{x + xn}, #{y + yn} = #{Map.get(grid, {x + xn, y + yn}, 0)}")
      Map.get(grid, {x + xn, y + yn}, 0)
    end
    |> Enum.sum()
  end


  def sum_block_reducer({x, y}, %{n: 0, grid: grid, blocks: blocks}) do
    sum = sum_block(grid, {x, y})
    %{grid: grid, blocks: blocks |> Map.put("#{x},#{y}", sum)}
  end



  @doc """
  grid with my input
  """
  def grid(gsn \\ @gsn) do
    for x <- 0..300, y <- 0..300 do
      {x, y, gsn}
    end
    |> Enum.map(fn({x, y, g}) -> {x, y, g, power({x, y, g})} end)
    |> Enum.reduce(%{}, fn({x, y, g, v}, acc) -> acc |> Map.put({x, y}, v) end)
  end

  @doc """
  Get power level for {x,y,grid_serial}

  ## Examples

      iex> Fuel.power({3, 5, 8})
      4

      iex> Fuel.power({122, 79, 57})
      -5

      iex> Fuel.power({217, 196, 39})
      0

      iex> Fuel.power({101, 153, 71})
      4

  """
  def power({x, y, g}) do
    rack_id = (x + 10)
    n = ((rack_id * y) + g) * rack_id
    h = n |> Integer.to_string() |> String.at(-3) |> String.to_integer()
    h - 5
  end


  @doc """
  Function does...

  ## Examples

      iex> Fuel.func_template(:todo)
      :todo

      iex> Fuel.func_template(:more)
      :more

  """
  def func_template(nil), do: :nope
  def func_template(true), do: :yep
  def func_template(arg) do
    # Logger.info "invoked func_template(#{inspect(arg)}) (no skip)"
    arg
  end


end
