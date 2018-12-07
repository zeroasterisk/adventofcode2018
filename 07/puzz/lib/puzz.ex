

defmodule Puzz do
  @moduledoc """
  Documentation for Puzz.
  """
  # import Puzz.Helper
  require Logger

  @doc """
  main do stuff

  ## Examples

      iex> Puzz.main(:p1_test)
      "CABDFE"

      iex> Puzz.main(:p1)
      "JDEKPFABTUHOQSXVYMLZCNIGRW"

      iex> Puzz.main(:p2)
      :TODO

  """
  def main(:p1), do: Puzz.Helper.get_input() |> part_1()
  def main(:p1_test), do: Puzz.Helper.get_test() |> part_1()


  # def walk_deps([] = next_steps, solution,
  # def walk_deps([l | rest] = next_steps, solution,

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
  Assemble from available letters, iterativly/recursivly

  """
  def part_1(pairs) do
    # pairs = Puzz.Helper.get_test()

    # determine all dependancies
    deps = pairs |> Enum.reduce(%{}, &Puzz.compile_dependencies/2)
    # all unique letters
    letters = Enum.reduce(pairs, MapSet.new(), fn({l1, l2}, acc) -> acc |> MapSet.put(l1) |> MapSet.put(l1) end)
    # these letters are always unblocked, but we can only start with 1 of them
    free = MapSet.difference(letters, MapSet.new(Map.keys(deps))) |> MapSet.to_list() |> Enum.sort()

    # solve for each letter, get "all available" and pick "first"
    solution = assemble_from_available_letters([hd(free)], free, deps)
    solution |> Enum.reverse |> Enum.join("")
  end


  @doc """
  Recursivly assemble solution until there are no available letters to add
  - determine available letters based on a deps map, and free letters
  - reduce available letters based on deps map, and already-in-solution
  - pick alpha, first of available and add
  """
  def assemble_from_available_letters(solution, free, deps) do
    # collect a list of all allowed values given the current solution
    all_available = solution
                    # add in all possible letters, given this solution
                    |> Enum.reduce(MapSet.new(free), fn(l, acc) ->
                      letters = get_avail(l, deps)
                      acc |> MapSet.union(MapSet.new(letters))
                    end)
                    # omit if already in the solution
                    |> MapSet.difference(MapSet.new(solution))
                    |> MapSet.to_list()
                    # omit if not all of the dependancies are in solution
                    |> Enum.filter(fn(l) -> all_deps_present?(l, solution, deps) end)
                    # sort remaining for alpha
                    |> Enum.sort()
    case Enum.empty?(all_available) do
      true ->
        # well, I guess we're done here...
        solution
      false ->
        l = List.first(all_available)
        [l | solution] |> assemble_from_available_letters(free, deps)
    end
  end

  @doc """
  Get all available letters, based on dependancy map

  ## Examples

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_avail("E", deps)
      []

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_avail("A", deps)
      ["B", "D"]

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_avail("B", deps)
      ["E"]
  """
  def get_avail(l, deps) do
    deps
    |> Enum.filter(fn({_l1, req}) -> Enum.member?(req, l) end)
    |> Enum.map(fn({l1, _req}) -> l1 end)
  end

  @doc """
  Are all of the dependancies present in the solution, for any given letter?

  ## Examples

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.all_deps_present?("E", ["D"], deps)
      false

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.all_deps_present?("E", ["D", "B", "C"], deps)
      false

      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.all_deps_present?("E", ["D", "B", "F", "C"], deps)
      true

  """
  def all_deps_present?(l1, solution, deps) do
    req = Map.get(deps, l1, [])
    MapSet.difference(
      MapSet.new(req),
      MapSet.new(solution)
    ) |> MapSet.size() == 0
  end

  @doc """
  Compile a map of dependancies for each node

  ## Examples

      iex> Puzz.compile_dependencies({"C", "A"}, %{})
      %{"A" => ["C"]}

      iex> Puzz.compile_dependencies({"C", "F"}, %{"A" => ["C"]})
      %{"A" => ["C"], "F" => ["C"]}

      iex> Puzz.compile_dependencies({"A", "B"}, %{"A" => ["C"], "F" => ["C"]})
      %{"A" => ["C"], "F" => ["C"], "B" => ["A"]}

      iex> Puzz.compile_dependencies({"J", "A"}, %{"A" => ["C"]})
      %{"A" => ["J", "C"]}


  """
  def compile_dependencies({l1, l2}, %{} = acc) do
    Map.put(acc, l2, [l1 | Map.get(acc, l2, [])])
  end

  @doc """
  Compile a list of available letters for each node

  ## Examples

      iex> Puzz.compile_avails({"C", "A"}, %{})
      %{"C" => ["A"]}

      iex> Puzz.compile_avails({"C", "F"}, %{"C" => ["A"]})
      %{"C" => ["F", "A"]}

      iex> Puzz.compile_avails({"A", "B"}, %{"C" => ["F", "A"]})
      %{"C" => ["F", "A"], "A" => ["B"]}


  """
  def compile_avails({l1, l2}, %{} = acc) do
    Map.put(acc, l1, [l2 | Map.get(acc, l1, [])])
  end

  @doc """
  Function does...

  ## Examples

      iex> Puzz.func_template(:todo)
      :todo

      iex> Puzz.func_template(:more)
      :more

  """
  def func_template(nil), do: :nope
  def func_template(true), do: :yep
  def func_template(arg) do
    # Logger.info "invoked func_template(#{inspect(arg)}) (no skip)"
    arg
  end


end
