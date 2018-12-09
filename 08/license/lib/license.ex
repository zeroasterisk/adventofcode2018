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

      iex> License.main(:p1)
      :TODO

      iex> License.main(:p2)
      :TODO

  """
  def main(:p1_test) do
    License.Helper.get_test
    |> parse()
    # TODO reduce to sum metadata
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
  Parse input into LNode{} structs (with all children)
  """
  def parse(str) when is_bitstring(str), do: String.split(str, " ") |> Enum.map(&String.to_integer/1)
  def parse(list_of_numbers) do
    {list_of_numbers, []} |> consume_child()
  end
  @doc """
  This is always begun on the header of a node, and consumes a single child (and all of it's children)
  - number_children
  - number_metadata
  - X children (and all of their stuff)
  - X metadata
  returns {node, list_of_numbers}
  """
  def consume_child([number_children | number_metadata | rest]) do
    %LNode{
      number_children: number_children,
      number_metadata: number_metadata,
      children: [], # X times, grab child (recurse)
      metadata: [], # X times, grab metadata (simple)
    }
    |> populate_child({rest, number_children, number_metadata}, nodes)
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
    {[m | list_of_numbers], 0 = _number_children_left, number_metadata_left}
  ) do
    lnode |> Map.merge(%{metadata: [m | metadata]})
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
