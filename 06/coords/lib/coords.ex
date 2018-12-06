


defmodule Point do
  defstruct [
    x: 0,
    y: 0,
    type: :grid, # :origin
    id: nil, # origin id, either for an origin point, or for nearest calculated origin
    dist: 0, # dist to nearest point
  ]
end
defmodule Group do
  defstruct [
    id: nil, # origin id, either for an origin point, or for nearest calculated origin
    points: [],
    point_count: 0,
    edge: false,
  ]
end

defmodule Coords do
  @moduledoc """
  Documentation for Coords.
  """

  @origins [
    %Point{type: :origin, x: 158, y: 163, id: :o158_163},
    %Point{type: :origin, x: 287, y: 68, id: :o287_68},
    %Point{type: :origin, x: 76, y: 102, id: :o76_102},
    %Point{type: :origin, x: 84, y: 244, id: :o84_244},
    %Point{type: :origin, x: 162, y: 55, id: :o162_55},
    %Point{type: :origin, x: 272, y: 335, id: :o272_335},
    %Point{type: :origin, x: 345, y: 358, id: :o345_358},
    %Point{type: :origin, x: 210, y: 211, id: :o210_211},
    %Point{type: :origin, x: 343, y: 206, id: :o343_206},
    %Point{type: :origin, x: 219, y: 323, id: :o219_323},
    %Point{type: :origin, x: 260, y: 238, id: :o260_238},
    %Point{type: :origin, x: 83, y: 94, id: :o83_94},
    %Point{type: :origin, x: 137, y: 340, id: :o137_340},
    %Point{type: :origin, x: 244, y: 172, id: :o244_172},
    %Point{type: :origin, x: 335, y: 307, id: :o335_307},
    %Point{type: :origin, x: 52, y: 135, id: :o52_135},
    %Point{type: :origin, x: 312, y: 109, id: :o312_109},
    %Point{type: :origin, x: 276, y: 93, id: :o276_93},
    %Point{type: :origin, x: 288, y: 274, id: :o288_274},
    %Point{type: :origin, x: 173, y: 211, id: :o173_211},
    %Point{type: :origin, x: 125, y: 236, id: :o125_236},
    %Point{type: :origin, x: 200, y: 217, id: :o200_217},
    %Point{type: :origin, x: 339, y: 56, id: :o339_56},
    %Point{type: :origin, x: 286, y: 134, id: :o286_134},
    %Point{type: :origin, x: 310, y: 192, id: :o310_192},
    %Point{type: :origin, x: 169, y: 192, id: :o169_192},
    %Point{type: :origin, x: 313, y: 106, id: :o313_106},
    %Point{type: :origin, x: 331, y: 186, id: :o331_186},
    %Point{type: :origin, x: 40, y: 236, id: :o40_236},
    %Point{type: :origin, x: 194, y: 122, id: :o194_122},
    %Point{type: :origin, x: 244, y: 76, id: :o244_76},
    %Point{type: :origin, x: 159, y: 282, id: :o159_282},
    %Point{type: :origin, x: 161, y: 176, id: :o161_176},
    %Point{type: :origin, x: 262, y: 279, id: :o262_279},
    %Point{type: :origin, x: 184, y: 93, id: :o184_93},
    %Point{type: :origin, x: 337, y: 284, id: :o337_284},
    %Point{type: :origin, x: 346, y: 342, id: :o346_342},
    %Point{type: :origin, x: 283, y: 90, id: :o283_90},
    %Point{type: :origin, x: 279, y: 162, id: :o279_162},
    %Point{type: :origin, x: 112, y: 244, id: :o112_244},
    %Point{type: :origin, x: 49, y: 254, id: :o49_254},
    %Point{type: :origin, x: 63, y: 176, id: :o63_176},
    %Point{type: :origin, x: 268, y: 145, id: :o268_145},
    %Point{type: :origin, x: 334, y: 336, id: :o334_336},
    %Point{type: :origin, x: 278, y: 176, id: :o278_176},
    %Point{type: :origin, x: 353, y: 135, id: :o353_135},
    %Point{type: :origin, x: 282, y: 312, id: :o282_312},
    %Point{type: :origin, x: 96, y: 85, id: :o96_85},
    %Point{type: :origin, x: 90, y: 105, id: :o90_105},
    %Point{type: :origin, x: 354, y: 312, id: :o354_312},
  ]

  @doc """
  Manhattan dist
  """
  def dist(%Point{x: x1, y: y1}, %Point{x: x2, y: y2}) do
    abs(x2 - x1) + abs(y2 - y1)
  end
  def dist_origins(%Point{} = a) do
    @origins
    |> Enum.map(fn(o) -> {o, dist(o, a)} end)
    |> Enum.sort_by(fn({_o, d}) -> d end)
  end
  def assign_origin(%Point{} = a) do
    sorted = dist_origins(a)
    {first, sorted} = sorted |> List.pop_at(0)
    {second, _rest} = sorted |> List.pop_at(0)
    assign_origin(a, first, second)
  end
  def assign_origin(%Point{} = a, {o1, d1}, {_o2, d2}) do
    case d1 == d2 do
      true -> a |> Map.merge(%{id: :none, dist: d1})
      false -> a |> Map.merge(%{id: o1.id, dist: d1})
    end
  end




  @doc """
  build grid and assign points

  ## Examples

      iex> Coords.grid(5)
      [
        %Point{dist: 177, id: :o83_94, type: :grid, x: 0, y: 0},
        %Point{dist: 176, id: :o83_94, type: :grid, x: 0, y: 1},
        %Point{dist: 175, id: :o83_94, type: :grid, x: 0, y: 2},
        %Point{dist: 174, id: :o83_94, type: :grid, x: 0, y: 3},
        %Point{dist: 173, id: :o83_94, type: :grid, x: 0, y: 4},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 0, y: 5},
        %Point{dist: 176, id: :o83_94, type: :grid, x: 1, y: 0},
        %Point{dist: 175, id: :o83_94, type: :grid, x: 1, y: 1},
        %Point{dist: 174, id: :o83_94, type: :grid, x: 1, y: 2},
        %Point{dist: 173, id: :o83_94, type: :grid, x: 1, y: 3},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 1, y: 4},
        %Point{dist: 171, id: :o83_94, type: :grid, x: 1, y: 5},
        %Point{dist: 175, id: :o83_94, type: :grid, x: 2, y: 0},
        %Point{dist: 174, id: :o83_94, type: :grid, x: 2, y: 1},
        %Point{dist: 173, id: :o83_94, type: :grid, x: 2, y: 2},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 2, y: 3},
        %Point{dist: 171, id: :o83_94, type: :grid, x: 2, y: 4},
        %Point{dist: 170, id: :o83_94, type: :grid, x: 2, y: 5},
        %Point{dist: 174, id: :o83_94, type: :grid, x: 3, y: 0},
        %Point{dist: 173, id: :o83_94, type: :grid, x: 3, y: 1},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 3, y: 2},
        %Point{dist: 171, id: :o83_94, type: :grid, x: 3, y: 3},
        %Point{dist: 170, id: :o83_94, type: :grid, x: 3, y: 4},
        %Point{dist: 169, id: :o83_94, type: :grid, x: 3, y: 5},
        %Point{dist: 173, id: :o83_94, type: :grid, x: 4, y: 0},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 4, y: 1},
        %Point{dist: 171, id: :o83_94, type: :grid, x: 4, y: 2},
        %Point{dist: 170, id: :o83_94, type: :grid, x: 4, y: 3},
        %Point{dist: 169, id: :o83_94, type: :grid, x: 4, y: 4},
        %Point{dist: 168, id: :o83_94, type: :grid, x: 4, y: 5},
        %Point{dist: 172, id: :o83_94, type: :grid, x: 5, y: 0},
        %Point{dist: 171, id: :o83_94, type: :grid, x: 5, y: 1},
        %Point{dist: 170, id: :o83_94, type: :grid, x: 5, y: 2},
        %Point{dist: 169, id: :o83_94, type: :grid, x: 5, y: 3},
        %Point{dist: 168, id: :o83_94, type: :grid, x: 5, y: 4},
        %Point{dist: 167, id: :o83_94, type: :grid, x: 5, y: 5}
      ]

  """
  def grid(max \\ 500) do
    for x <- 0..max, y <- 0..max do
      %Point{x: x, y: y} |> assign_origin()
    end
  end

  @doc """
  calculate the answer to part 1

  ## Examples

      iex> Coords.p1(500)
      4215

  """
  def p1(max \\ 500) do
    {id, group} = max
                  |> grid()
                  # group into a map, organized by
                  |> Enum.reduce(%{}, &p1_grouper/2)
                  # exclude edge nodes
                  |> Enum.filter(fn({id, group}) -> Map.get(group, :edge) == false end)
                  # sort by highest count
                  |> Enum.sort_by(fn({id, group}) -> Map.get(group, :point_count) end)
                  # last is highest
                  |> List.last()
    # we want the point count
    Map.get(group, :point_count)
  end
  # reject the :none (non counting points)
  def p1_grouper(%Point{id: :none} = a, %{} = acc), do: acc
  # reject the edge-touching-notes (infinite)
  def p1_grouper(%Point{x: 0} = a, %{} = acc), do: a |> p1_grouper_reject_edge(acc)
  def p1_grouper(%Point{y: 0} = a, %{} = acc), do: a |> p1_grouper_reject_edge(acc)
  def p1_grouper(%Point{x: 500} = a, %{} = acc), do: a |> p1_grouper_reject_edge(acc)
  def p1_grouper(%Point{y: 500} = a, %{} = acc), do: a |> p1_grouper_reject_edge(acc)
  # add each point to a list of points for the acc
  def p1_grouper(%Point{id: id} = a, %{} = acc) do
    group = acc |> Map.get(id, %Group{})
    points = group |> Map.get(:points, [])
    points = [a | points]
    group = group
            |> Map.put(:points, points)
            |> Map.put(:point_count, Enum.count(points))
    acc |> Map.put(id, group)
  end

  defp p1_grouper_reject_edge(%Point{id: id}, %{} = acc) do
    group = acc
            |> Map.get(id, %Group{})
            |> Map.merge(%{edge: true})
    acc |> Map.put(id, group)
  end

end
