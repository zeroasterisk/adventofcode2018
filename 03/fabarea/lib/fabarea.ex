defmodule Fabarea.Claim do
  defstruct [
    claim_number: nil,
    skip_x: nil,
    skip_y: nil,
    x: nil,
    y: nil,
  ]

  @doc """
  Pad the matrix, to the left

  ## Examples

      iex> claim = %Fabarea.Claim{claim_number: 1, skip_x: 1, skip_y: 3, x: 4, y: 4}
      iex> Fabarea.Claim.to_matrix(claim)
      [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1],
        [0, 1, 1, 1, 1],
        [0, 1, 1, 1, 1],
        [0, 1, 1, 1, 1]
      ]
  """
  def to_matrix(%Fabarea.Claim{skip_x: skip_x, skip_y: skip_y, x: x, y: y}) do
    Matrix.ones(x, y)
    |> pad_left(skip_x)
    |> pad_top(skip_y)
  end

  @doc """
  Pad the matrix, to the top

  ## Examples

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_top(trix, 4)
      [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [1, 1, 1], [1, 1, 1], [1, 1, 1]]

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_top(trix, 0)
      [[1, 1, 1], [1, 1, 1], [1, 1, 1]]

  """
  def pad_top(trix, 0), do: trix
  def pad_top(trix, n) do
    {_rows, cols} = Matrix.size(trix)
    top = Matrix.zeros(n, cols)
    top ++ trix
  end

  @doc """
  Pad the matrix, to the right (this is fast)

  ## Examples

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_right(trix, 4)
      [[1, 1, 1, 0, 0, 0, 0], [1, 1, 1, 0, 0, 0, 0], [1, 1, 1, 0, 0, 0, 0]]

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_right(trix, 0)
      [[1, 1, 1], [1, 1, 1], [1, 1, 1]]

  """
  def pad_right(trix, 0), do: trix
  def pad_right(trix, n) do
    padding = Matrix.new(1, n) |> List.first()
    trix
    |> Enum.map(fn(r) -> r ++ padding end)
  end

  @doc """
  Pad the matrix, to the bottom

  ## Examples

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_bottom(trix, 4)
      [[1, 1, 1], [1, 1, 1], [1, 1, 1], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_bottom(trix, 0)
      [[1, 1, 1], [1, 1, 1], [1, 1, 1]]

  """
  def pad_bottom(trix, 0), do: trix
  def pad_bottom(trix, n) do
    {_rows, cols} = Matrix.size(trix)
    bottom = Matrix.zeros(n, cols)
    trix ++ bottom
  end

  @doc """
  Pad the matrix, to the left (this is fast)

  ## Examples

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_left(trix, 4)
      [[0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 1, 1, 1], [0, 0, 0, 0, 1, 1, 1]]

      iex> trix = Matrix.ones(3, 3)
      iex> Fabarea.Claim.pad_left(trix, 0)
      [[1, 1, 1], [1, 1, 1], [1, 1, 1]]

  """
  def pad_left(trix, 0), do: trix
  def pad_left(trix, n) do
    trix
    |> Enum.map(fn(r) -> [0 | r] end)
    # |> Matrix.prefix_rows(0)
    |> pad_left(n - 1)
  end


  @doc """
  Expand the matrix, to the size of the fabric

  ## Examples

      iex> fabric = Matrix.zeros(8, 8)
      iex> claim = %Fabarea.Claim{claim_number: 1, skip_x: 1, skip_y: 3, x: 4, y: 4}
      iex> Fabarea.Claim.size_to_fabric(claim, fabric)
      [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]

      iex> fabric = Matrix.zeros(7, 7)
      iex> claim = %Fabarea.Claim{claim_number: 1, skip_x: 1, skip_y: 3, x: 4, y: 4}
      iex> Fabarea.Claim.size_to_fabric(claim, fabric)
      [
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0],
        [0, 1, 1, 1, 1, 0, 0],
        [0, 1, 1, 1, 1, 0, 0],
        [0, 1, 1, 1, 1, 0, 0],
      ]

  """
  def size_to_fabric(%Fabarea.Claim{} = claim, fabric) do
    claim |> Fabarea.Claim.to_matrix() |> Fabarea.Claim.size_to_fabric(fabric)
  end
  def size_to_fabric(trix, fabric) do
    {to_rows, to_cols} = Matrix.size(fabric)
    {is_rows, is_cols} = Matrix.size(trix)
    grow_x = max(0, to_cols - is_cols)
    grow_y = max(0, to_rows - is_rows)
    trix |> pad_right(grow_x) |> pad_bottom(grow_y)
  end
end


defmodule Fabarea do
  @moduledoc """
  Documentation for Fabarea.
  """


  @doc """
  Apply a single claim line onto the fabric

  ## Examples

      iex> fabric = Matrix.new(8, 8)
      iex> claim = Fabarea.parse_claim("#1 @ 1,3: 4x4")
      iex> Fabarea.apply_claim(fabric, claim)
      [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]

      iex> fabric = Matrix.new(8, 8)
      iex> claim = Fabarea.parse_claim("#1 @ 1,3: 4x4")
      iex> fabric = Fabarea.apply_claim(fabric, claim)
      iex> claim = Fabarea.parse_claim("#2 @ 3,1: 4x4")
      iex> Fabarea.apply_claim(fabric, claim)
      [
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 1, 1, 1, 1, 0],
        [0, 0, 0, 1, 1, 1, 1, 0],
        [0, 1, 1, 2, 2, 1, 1, 0],
        [0, 1, 1, 2, 2, 1, 1, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 1, 1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
      ]
  """
  def apply_claim(fabric, %Fabarea.Claim{} = claim) do
    patch = claim
            |> Fabarea.Claim.to_matrix()
            |> Fabarea.Claim.size_to_fabric(fabric)
    fabric |> Matrix.add(patch)
  end


  @doc """
  Parse a single claim line from input file into a Struct

  ## Examples

      iex> Fabarea.parse_claim("#1 @ 1,3: 4x4")
      %Fabarea.Claim{claim_number: 1, skip_x: 1, skip_y: 3, x: 4, y: 4}

  """
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
  def parse_claim(str) do
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
