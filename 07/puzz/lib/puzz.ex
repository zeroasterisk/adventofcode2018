

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

      iex> Puzz.main(:p2_test)
      {"CABFDE", 15}

      iex> Puzz.main(:p2)
      {"JKXDEPTFABUHOQSVYZMLNCIGRW", 1048}

  """
  def main(:p1), do: Puzz.Helper.get_input() |> part_1()
  def main(:p1_test), do: Puzz.Helper.get_test() |> part_1()
  def main(:p2), do: Puzz.Helper.get_input() |> part_2(%{allowed_workers: 5, sec_prefix: 60})
  def main(:p2_test), do: Puzz.Helper.get_test() |> part_2(%{allowed_workers: 2, sec_prefix: 0})

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
    letters = Enum.reduce(pairs, MapSet.new(), fn({l1, _l2}, acc) -> acc |> MapSet.put(l1) |> MapSet.put(l1) end)
    # these letters are always unblocked, but we can only start with 1 of them
    free = MapSet.difference(letters, MapSet.new(Map.keys(deps))) |> MapSet.to_list() |> Enum.sort()

    # solve for each letter, get "all available" and pick "first"
    solution = assemble_from_available_letters([hd(free)], free, deps)
    solution |> Enum.reverse |> Enum.join("")
  end

  @doc """
  Assemble from available letters, iterativly/recursivly,
  allocate 5 workers
  each letter takes 60+<i> to complete

  """
  def part_2(pairs, %{allowed_workers: allowed_workers, sec_prefix: sec_prefix}) do
    # pairs = Puzz.Helper.get_test()

    # determine all dependancies
    deps = pairs |> Enum.reduce(%{}, &Puzz.compile_dependencies/2)
    # all unique letters
    letters = Enum.reduce(pairs, MapSet.new(), fn({l1, _l2}, acc) -> acc |> MapSet.put(l1) |> MapSet.put(l1) end)
    # these letters are always unblocked, but we can only start with 1 of them
    free = MapSet.difference(letters, MapSet.new(Map.keys(deps))) |> MapSet.to_list() |> Enum.sort()

    # solve for each letter, get "all available" and pick "first"
    acc = %{
      allowed_workers: allowed_workers,
      sec_prefix: sec_prefix,
      solution: [],
      free: free,
      deps: deps,
      sec: 0,
      workers: [],
    } |> worker_loop()

    # IO.inspect(acc)
    {
      acc.solution |> Enum.reverse |> Enum.join(""),
      acc.sec - 1
    }
  end

  @doc """
  iex> Puzz.letter_sec("A", 60)
  61
  iex> Puzz.letter_sec("B", 60)
  62
  """
  def letter_sec(l, sec_prefix) do
    Puzz.Helper.letter_index(l) + sec_prefix
  end



  @doc """
  Recursivly assemble solution until there are no available letters to add
  - determine available letters based on a deps map, and free letters
  - reduce available letters based on deps map, and already-in-solution
  - pick alpha, first of available and add
  """
  def worker_loop(%{worker_count: 0, sec: sec} = acc) when sec > 0, do: acc
  def worker_loop(%{} = acc) do
    acc
    # iterate at lead of loop, because "done" check is <= (subtract sec at the end)
    |> iterate_time()
    |> expire_workers()
    |> assign_available_letters()
    |> add_workers()
    |> worker_loop()
  end

  @doc """
  One clock tick forward please

      iex> Puzz.iterate_time(%{sec: 124})
      %{ sec: 125 }
  """
  def iterate_time(%{sec: sec} = acc), do: acc |> Map.put(:sec, sec + 1)


  @doc """
  Is a worker done?
  Done at the second (leading edge), not after

      iex> Puzz.worker_done?(%{until: 124}, 124)
      true

      iex> Puzz.worker_done?(%{until: 125}, 124)
      false
  """
  def worker_done?(%{until: until}, sec), do: until <= sec

  @doc """
  Expire any workers, and add letters to the solution

      iex> Puzz.expire_workers(%{
      ...>  sec: 124,
      ...>  solution: ["C"],
      ...>  worker_count: 2,
      ...>  workers: [%{until: 125, letter: "A"}, %{until: 130, letter: "F"}]
      ...>})
      %{
        sec: 124,
        solution: ["C"],
        worker_count: 2,
        workers: [%{until: 125, letter: "A"}, %{until: 130, letter: "F"}]
      }

      iex> Puzz.expire_workers(%{
      ...>  sec: 125,
      ...>  solution: ["C"],
      ...>  worker_count: 2,
      ...>  workers: [%{until: 125, letter: "A"}, %{until: 130, letter: "F"}]
      ...>})
      %{
        sec: 125,
        solution: ["A", "C"],
        worker_count: 1,
        workers: [%{until: 130, letter: "F"}]
      }
  """
  def expire_workers(%{worker_count: 0} = acc), do: acc
  def expire_workers(%{solution: solution, sec: sec, workers: workers} = acc) do
    letters = workers
              |> Enum.filter(fn(wkr) -> worker_done?(wkr, sec) end)
              |> Enum.map(fn(%{letter: l}) -> l end)
              |> Enum.sort()
              |> Enum.reverse()
    case Enum.empty?(letters) do
      true -> acc
      false ->

        workers = workers
                  |> Enum.filter(fn(wkr) -> worker_done?(wkr, sec) == false end)
        acc = acc |> Map.merge(%{
          solution: letters ++ solution,
          workers: workers,
          worker_count: Enum.count(workers),
        })
        # letter_count = Enum.count(letters)
        # Logger.debug("expire #{letter_count} workers @ #{sec} sec [#{acc.solution |> Enum.reverse |> Enum.join("")}]")
        # Logger.debug("  remaining workers #{inspect(acc.workers)}")
        acc
    end
  end

  @doc """
  Gather avaialable letters, based on solution + deps + free
  Omit any letter that's already in a worker

      iex> Puzz.assign_available_letters(%{
      ...>  sec: 125,
      ...>  solution: ["C"],
      ...>  free: ["C"],
      ...>  deps: %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]},
      ...>  worker_count: 2,
      ...>  workers: []
      ...>})
      %{
        available_count: 2,
        available: ["A", "F"],
        sec: 125,
        solution: ["C"],
        free: ["C"],
        deps: %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]},
        worker_count: 2,
        workers: []
      }

      iex> Puzz.assign_available_letters(%{
      ...>  sec: 125,
      ...>  solution: ["C"],
      ...>  free: ["C"],
      ...>  deps: %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]},
      ...>  worker_count: 2,
      ...>  workers: [%{until: 125, letter: "A"}, %{until: 130, letter: "F"}]
      ...>})
      %{
        available_count: 0,
        available: [],
        sec: 125,
        solution: ["C"],
        free: ["C"],
        deps: %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]},
        worker_count: 2,
        workers: [%{until: 125, letter: "A"}, %{until: 130, letter: "F"}]
      }
  """
  def assign_available_letters(%{solution: solution, free: free, deps: deps, workers: workers} = acc) do
    worker_letters = Enum.map(workers, fn(%{letter: l}) -> l end)
    available = get_available_letters(solution, free, deps)
                |> Enum.filter(fn(l) -> Enum.member?(worker_letters, l) == false end)
    acc |> Map.merge(%{
      available: available,
      available_count: Enum.count(available),
    })
  end

  @doc """
  Add in workers, for available letters, if there is room

      iex> Puzz.add_workers(%{worker_count: 5})
      %{worker_count: 5}

      iex> Puzz.add_workers(%{available_count: 0})
      %{available_count: 0}


      iex> Puzz.add_workers(%{
      ...>  available_count: 3,
      ...>  available: ["A", "B", "C"],
      ...>  sec: 125,
      ...>  sec_prefix: 60,
      ...>  allowed_workers: 5,
      ...>  worker_count: 1,
      ...>  workers: [%{until: 130, letter: "Z"}]
      ...>})
      %{
        available_count: 3,
        available: ["A", "B", "C"],
        sec: 125,
        sec_prefix: 60,
        allowed_workers: 5,
        worker_count: 4,
        workers: [%{until: 130, letter: "Z"}, %{letter: "A", until: 186}, %{letter: "B", until: 187}, %{letter: "C", until: 188}]
      }
  """
  def add_workers(%{worker_count: 5} = acc), do: acc
  def add_workers(%{available_count: 0} = acc), do: acc
  def add_workers(%{available: available, sec: sec, sec_prefix: sec_prefix, allowed_workers: allowed_workers, workers: workers} = acc) do
    n = allowed_workers - Enum.count(workers)
    new_workers = available
                  |> Enum.slice(0, n)
                  |> Enum.map(fn(l) -> %{until: sec + letter_sec(l, sec_prefix), letter: l} end)

    workers = workers ++ new_workers
    acc = acc |> Map.merge(%{
      workers: workers,
      worker_count: Enum.count(workers),
    })
    # Logger.debug("add_workers #{Enum.count(new_workers)}/#{n} in @ #{sec} sec")
    # Logger.debug("  remaining workers #{inspect(acc.workers)}")
    acc
  end


  @doc """
  look at all deps and determine which letters are currently allowed

      iex> solution = []
      iex> free = ["C"]
      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_available_letters(solution, free, deps)
      ["C"]

      iex> solution = ["C"]
      iex> free = ["C"]
      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_available_letters(solution, free, deps)
      ["A", "F"]

      iex> solution = ["A", "C"]
      iex> free = ["C"]
      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_available_letters(solution, free, deps)
      ["B", "D", "F"]

      iex> solution = ["B", "D", "A", "C"]
      iex> free = ["C"]
      iex> deps = %{"A" => ["C"], "B" => ["A"], "D" => ["A"], "E" => ["F", "D", "B"], "F" => ["C"]}
      iex> Puzz.get_available_letters(solution, free, deps)
      ["F"]
  """
  def get_available_letters(solution, free, deps) do
    # collect a list of all allowed values given the current solution
    solution
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
  end



  @doc """
  Recursivly assemble solution until there are no available letters to add
  - determine available letters based on a deps map, and free letters
  - reduce available letters based on deps map, and already-in-solution
  - pick alpha, first of available and add
  """
  def assemble_from_available_letters(solution, free, deps) do
    available = get_available_letters(solution, free, deps)
    case Enum.empty?(available) do
      true ->
        # well, I guess we're done here...
        solution
      false ->
        l = List.first(available)
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
