defmodule LNode do
  defstruct [
    number_children: 0,
    number_metadata: 0,
    children: [
    ],
    metadata: [
    ]
  ]
end
defmodule License do
  @moduledoc """
  Documentation for License.
  """
  # import License.Helper
  require Logger

  @doc """
  main do stuff

  ## Examples

      iex> License.main(:p1_test)
      138

      iex> License.main(:p1)
      43996

      iex> License.main(:p2_test)
      66

      iex> License.main(:p2)
      35189

  """
  def main(:p1_test) do
    License.Helper.get_test
    |> parse()
    |> Enum.reduce(0, &sum_metadata/2)
  end
  def main(:p1) do
    License.Helper.get_input
    |> parse()
    |> Enum.reduce(0, &sum_metadata/2)
  end
  def main(:p2_test) do
    License.Helper.get_test
    |> parse()
    |> Enum.reduce(0, &sum_metadata_refs/2)
  end
  def main(:p2) do
    License.Helper.get_input
    |> parse()
    |> Enum.reduce(0, &sum_metadata_refs/2)
  end
  def main(arg) do
    Logger.info "invoked main(#{inspect(arg)})"
    arg
  end

  # simple sum metadata
  def sum_metadata(%LNode{children: [], metadata: metadata}, sum) do
    Enum.sum(metadata) + sum
  end
  def sum_metadata(%LNode{children: children, metadata: metadata}, sum) do
    Enum.sum(metadata) + sum + Enum.reduce(children, 0, &sum_metadata/2)
  end

  # complecated sum metadata with references to child nodes
  def sum_metadata_refs(0, sum), do: sum
  def sum_metadata_refs(%LNode{children: [], metadata: metadata}, sum) do
    Enum.sum(metadata) + sum
  end
  def sum_metadata_refs(%LNode{children: children, metadata: metadata}, sum) do
    # to be smart, we should only calculate child sums which are used
    #   we should only do so, once (we may sum the same child multiple times)
    children = Enum.reverse(children) # reversed because they were compiled in reverse order
    children_count = Enum.count(children)
    child_map = Enum.reduce(metadata, %{}, fn(m, acc) ->
      m_key = Integer.to_string(m)
      case m <= 0 || m > children_count || Map.has_key?(acc, m_key) do
        true -> acc
        false ->
          child = Enum.at(children, m - 1)
          child_sum = sum_metadata_refs(child, 0) # recursive
          acc |> Map.put(m_key, child_sum)
      end
    end)
    # map metadata onto child_sums
    child_sum = metadata
                |> Enum.map(fn(m) ->
                  m_key = Integer.to_string(m)
                  Map.get(child_map, m_key, 0)
                end)
                |> Enum.sum()
    child_sum + sum
  end

  @doc """
  Parse input into LNode{} structs (with all children)
  """
  def parse(str) when is_bitstring(str) do
    str
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> parse([])
  end
  def parse([], nodes), do: nodes
  def parse(list_of_numbers, nodes) do
    {lnode, list_of_numbers} = consume_child(list_of_numbers)
    parse(list_of_numbers, [lnode | nodes])
  end
  @doc """
  This is always begun on the header of a node, and consumes a single child (and all of it's children)
  - number_children
  - number_metadata
  - X children (and all of their stuff)
  - X metadata
  returns {node, list_of_numbers}
  """
  def consume_child([number_children | rest]) do
    consume_child(number_children, rest)
  end
  def consume_child(number_children, [number_metadata | rest]) do
    consume_child(number_children, number_metadata, rest)
  end
  def consume_child(number_children, number_metadata, rest) do
    %LNode{
      number_children: number_children,
      number_metadata: number_metadata,
      children: [], # X times, grab child (recurse)
      metadata: [0], # X times, grab metadata (simple)
    }
    |> populate_child({rest, number_children, number_metadata})
  end
  @doc """
  This is where we consume all of the child and metadata nodes
  - number_children_left = 0
  - number_metadata_left = 0
  returns {node, list_of_numbers}
  """
  # all childent are added, return {list, nodes} tuple
  def populate_child(
    %LNode{} = lnode,
    {list_of_numbers, 0 = _number_children_left, 0 = _number_metadata_left}
  ) do
    {lnode, list_of_numbers}
  end
  # add a metadata until metadata are done
  def populate_child(
    %LNode{metadata: metadata} = lnode,
    {[m_item | list_of_numbers], 0 = _number_children_left, number_metadata_left}
  ) when is_integer(m_item) do
    new_metadata = [m_item | metadata]
    # IO.inspect({lnode, m_item, list_of_numbers, number_metadata_left, new_metadata})
    lnode |> Map.merge(%{metadata: new_metadata})
    |> populate_child({list_of_numbers, 0, number_metadata_left - 1})
  end
  # add a child until children are done
  def populate_child(
    %LNode{children: children} = lnode,
    {list_of_numbers, number_children_left, number_metadata_left}
  ) do
    # pull a child
    {new_child, list_of_numbers} = consume_child(list_of_numbers)

    # return into this node's children and return the list
    lnode |> Map.merge(%{children: [new_child | children]})
    |> populate_child({list_of_numbers, number_children_left - 1, number_metadata_left})
  end

  @doc """
  Function does...

  ## Examples

      iex> License.func_template(:todo)
      :todo

      iex> License.func_template(:more)
      :more

  """
  def func_template(nil), do: :nope
  def func_template(true), do: :yep
  def func_template(arg) do
    # Logger.info "invoked func_template(#{inspect(arg)}) (no skip)"
    arg
  end


end
