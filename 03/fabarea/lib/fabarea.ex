defmodule Fabarea.Claim do
  defstruct [
    claim_number: nil,
    skip_x: nil,
    skip_y: nil,
    x: nil,
    y: nil,
  ]
end


defmodule Fabarea do
  @moduledoc """
  Documentation for Fabarea.
  """

  @doc """
  Increment a single node in a map with {x, y} keys

  ## Examples

      iex> fabric = %{}
      iex> Fabarea.increment({2, 3}, fabric)
      %{{2, 3} => 1}

      iex> fabric = Fabarea.increment({2, 3}, %{})
      iex> fabric = Fabarea.increment({2, 3}, fabric)
      iex> Fabarea.increment({3, 3}, fabric)
      %{{2, 3} => 2, {3, 3} => 1}
  """
  def increment({x, y}, fabric) do
    Fabarea.increment({x, y}, fabric, Map.get(fabric, {x, y}))
  end
  def increment({x, y}, fabric, nil) do
    Map.put(fabric, {x, y}, 1)
  end
  def increment({x, y}, fabric, value) do
    Map.put(fabric, {x, y}, value + 1)
  end

  @doc """
  Convert a claim into {x, y} coords
  #
  ## Examples

      iex> claim = Fabarea.parse_claim("#1 @ 0,0: 4x4")
      iex> Fabarea.claim_coords(claim)
      [
        {0, 0}, {1, 0}, {2, 0}, {3, 0},
        {0, 1}, {1, 1}, {2, 1}, {3, 1},
        {0, 2}, {1, 2}, {2, 2}, {3, 2},
        {0, 3}, {1, 3}, {2, 3}, {3, 3}
      ]

      iex> claim = Fabarea.parse_claim("#123 @ 3,2: 5x4")
      iex> Fabarea.claim_coords(claim)
      [
        {3, 2}, {4, 2}, {5, 2}, {6, 2}, {7, 2},
        {3, 3}, {4, 3}, {5, 3}, {6, 3}, {7, 3},
        {3, 4}, {4, 4}, {5, 4}, {6, 4}, {7, 4},
        {3, 5}, {4, 5}, {5, 5}, {6, 5}, {7, 5}
      ]
  """
  def claim_coords(%Fabarea.Claim{skip_x: skip_x, skip_y: skip_y, x: x, y: y}) do
    range_x = Range.new(skip_x, skip_x + x - 1)
    range_y = Range.new(skip_y, skip_y + y - 1)
    for y <- range_y, x <- range_x do
      {x, y}
    end
  end

  @doc """
  Apply a single claim line onto the fabric

  ## Examples

      iex> fabric = %{}
      iex> claim = Fabarea.parse_claim("#1 @ 1,3: 4x4")
      iex> Fabarea.apply_claim(claim, fabric)
      %{
        {1, 3} => 1, {1, 4} => 1, {1, 5} => 1, {1, 6} => 1,
        {2, 3} => 1, {2, 4} => 1, {2, 5} => 1, {2, 6} => 1,
        {3, 3} => 1, {3, 4} => 1, {3, 5} => 1, {3, 6} => 1,
        {4, 3} => 1, {4, 4} => 1, {4, 5} => 1, {4, 6} => 1
      }

      iex> fabric = %{}
      iex> fabric = Fabarea.apply_claim("#1 @ 1,3: 4x4", fabric)
      iex> Fabarea.apply_claim("#2 @ 3,1: 4x4", fabric)
      %{
        {1, 3} => 1, {1, 4} => 1, {1, 5} => 1, {1, 6} => 1,
        {2, 3} => 1, {2, 4} => 1, {2, 5} => 1, {2, 6} => 1,
        {3, 5} => 1, {3, 6} => 1, {4, 5} => 1, {4, 6} => 1,
        {3, 3} => 2, {3, 4} => 2, {4, 3} => 2, {4, 4} => 2,
        {3, 1} => 1, {3, 2} => 1, {4, 1} => 1, {4, 2} => 1,
        {5, 1} => 1, {5, 2} => 1, {5, 3} => 1, {5, 4} => 1,
        {6, 1} => 1, {6, 2} => 1, {6, 3} => 1, {6, 4} => 1
      }

      iex> fabric = %{}
      iex> fabric = Fabarea.apply_claim("#1 @ 1,3: 4x4", fabric)
      iex> fabric = Fabarea.apply_claim("#2 @ 3,1: 4x4", fabric)
      iex> Fabarea.apply_claim("#3 @ 5,5: 2x2", fabric)
      %{
        {1, 3} => 1, {1, 4} => 1, {1, 5} => 1, {1, 6} => 1,
        {2, 3} => 1, {2, 4} => 1, {2, 5} => 1, {2, 6} => 1,
        {3, 1} => 1, {3, 2} => 1, {3, 3} => 2, {3, 4} => 2,
        {3, 5} => 1, {3, 6} => 1, {4, 1} => 1, {4, 2} => 1,
        {4, 3} => 2, {4, 4} => 2, {4, 5} => 1, {4, 6} => 1,
        {5, 1} => 1, {5, 2} => 1, {5, 3} => 1, {5, 4} => 1,
        {5, 5} => 1, {5, 6} => 1, {6, 1} => 1, {6, 2} => 1,
        {6, 3} => 1, {6, 4} => 1, {6, 5} => 1, {6, 6} => 1
      }
  """
  def apply_claim(%Fabarea.Claim{} = claim, %{} = fabric) do
    claim
    |> Fabarea.claim_coords()
    |> Enum.reduce(fabric, &Fabarea.increment/2)
  end
  def apply_claim(claim, fabric) when is_bitstring(claim) do
    claim |> Fabarea.parse_claim() |> Fabarea.apply_claim(fabric)
  end

  @doc """
  Parse a single claim line from input file into a Struct

  ## Examples

      iex> Fabarea.parse_claim("#1 @ 1,3: 4x4")
      %Fabarea.Claim{claim_number: 1, skip_x: 1, skip_y: 3, x: 4, y: 4}

  """
  def parse_claim(%Fabarea.Claim{} = claim), do: claim
  def parse_claim([claim_number, skip_x, skip_y, x, y]) do
    %Fabarea.Claim{
      claim_number: claim_number,
      skip_x: skip_x,
      skip_y: skip_y,
      x: x,
      y: y,
    }
  end
  # "#" <> claim_number <> " @ " <> skip_x <> "," <> skip_y <> ": " <> x <> "x" <> y) do
  # TODO could have done w/ REGEX too
  def parse_claim(str) when is_bitstring(str) do
    str
    |> String.trim()
    |> String.replace("#", "")
    |> String.replace(" @ ", " ")
    |> String.replace(": ", " ")
    |> String.replace(",", " ")
    |> String.replace("x", " ")
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> parse_claim()
  end
end
