defmodule Reducer do
  @moduledoc """
  Documentation for Reducer.
  """
  import Reducer.Helper
  require Logger


  @doc """
  main do stuff

  ## Examples

      iex> Reducer.main(:p1)
      10584

      iex> Reducer.main(:p2)
      6968

  """
  def main(:p1) do
    Logger.info "How many units after fully reacted?"
    Reducer.Helper.input |> reducer() |> String.length() |> IO.inspect()
  end
  def main(:p2) do
    Logger.info "What's the shortest, omitting any 1 type of unit?"
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
"q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    |> Enum.map(fn(letter_to_omit) ->
      Reducer.Helper.input
      |> String.replace(letter_to_omit, "")
      |> String.replace(String.upcase(letter_to_omit), "")
      |> reducer() |> String.length()
      # |> IO.inspect()
    end)
    |> Enum.sort()
    |> List.first()
    |> IO.inspect()
  end

  @doc """
  React each letter

  ## Examples

      iex> letters = "dabCBAcCcaDA"
      iex> acc = %{reduced: false, result: [], last_letter: nil}
      iex> Reducer.reducer(letters, acc)
      "dabCBAcaDA"

      iex> letters = "dabAcCaCBAcCcaDA"
      iex> acc = %{reduced: false, result: [], last_letter: nil}
      iex> Reducer.reducer(letters, acc)
      "dabCBAcaDA"

  """
  # create a new accumulator as needed
  def reducer(letters), do: reducer(letters, %{reduced: false, result: [], last_letter: nil})
  # if string, split
  def reducer(letters, acc) when is_bitstring(letters), do: reducer(String.split(letters, "", trim: true), acc)
  # if done and not reduced, return as final result
  def reducer([], %{reduced: false} = acc), do: acc.result |> Enum.reverse() |> Enum.join("")
  # if done and reduced, recurse into self, with reduced result
  def reducer([], %{reduced: true} = acc), do: reducer(acc.result |> Enum.reverse())
  # no last_letter to compare to (yet)
  def reducer([letter | rest], %{last_letter: nil} = acc) do
    acc = reducer_step(rest, letter, acc)
    reducer(rest, acc)
  end

  # compare letter to last_letter
  def reducer([letter | rest], %{last_letter: last_letter} = acc) do
    acc = case caps?(letter) != caps?(last_letter) && String.upcase(letter) == String.upcase(last_letter) do
      true -> reducer_react(rest, letter, acc)
      false -> reducer_step(rest, letter, acc)
    end
    reducer(rest, acc)
  end

  @doc """
  step through to the next letter

  ## Examples

      iex> acc = %{reduced: false, result: ["c", "A", "B", "C", "b", "a", "d"], last_letter: "c"}
      iex> letter = "X"
      iex> rest = ["c", "a", "d"]
      iex> Reducer.reducer_step(rest, letter, acc)
      %{
        reduced: false,
        result: ["X", "c", "A", "B", "C", "b", "a", "d"],
        last_letter: "X"
      }
  """
  def reducer_step(_rest, letter, %{result: result} = acc) do
    # Logger.info("step #{letter} #{inspect(acc)}")
    Map.merge(acc, %{
      last_letter: letter,
      result: [letter | result], # this reverses the order... but that shouldn't matter
    })
  end

  @doc """
  react, kill the letter and the last_letter from the result

  ## Examples

      iex> acc = %{reduced: false, result: ["C", "c", "A", "B", "C", "b", "a", "d"], last_letter: "C"}
      iex> letter = "C"
      iex> rest = ["c", "a", "d"]
      iex> Reducer.reducer_react(rest, letter, acc)
      %{
        reduced: true,
        result: ["c", "A", "B", "C", "b", "a", "d"],
        last_letter: "c"
      }
  """
  def reducer_react(_rest, _letter, %{result: result, last_letter: last_letter} = acc) do
    # Logger.info("react #{letter} #{inspect(acc)}")
    {x_last_letter, x_result} = result |> List.pop_at(0)
    if last_letter != x_last_letter do
      raise "Explode!!!  #{last_letter} == #{x_last_letter}"
    end
    # walk back one more and reset to last_letter = 1 before
    {last_letter, result} = x_result |> List.pop_at(0)
    Map.merge(acc, %{
      reduced: true,
      last_letter: last_letter,
      result: [last_letter | result],
    })
  end


  @doc """
  is caps

  ## Examples

      iex> Reducer.caps?("A")
      true

      iex> Reducer.caps?("a")
      false

  """
  def caps?(letter), do: Regex.match?(~r/[A-Z]/, letter)

  @doc """
  Function does...

  ## Examples

      iex> Reducer.func_template(:todo)
      :todo

      iex> Reducer.func_template(:more)
      :more

  """
  def func_template(nil), do: :nope
  def func_template(true), do: :yep
  def func_template(arg) do
    # Logger.info "invoked func_template(#{inspect(arg)}) (no skip)"
    arg
  end


end
