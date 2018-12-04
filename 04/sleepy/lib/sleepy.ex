defmodule Guards do
  defstruct [
    current_id: nil,
    guards: %{}
  ]
end
defmodule Guard do
  defstruct [
    id: nil,
    sleep_log: [],
    sleep_mins: %{}, # Map when calculated from log
    total_asleep: 0
  ]
end
defmodule TimeLog do
  defstruct [
    start: nil, # min start
    stop: nil, # min stop
  ]
end
defmodule Sleepy do
  @moduledoc """
  Documentation for Sleepy.
  """

  @doc """
  calculate guard details after logs parsed

  ## Examples

  iex> %Guard{
  ...>   id: 10,
  ...>   sleep_log: [
  ...>     %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}},
  ...>     %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "05", "month" => "11", "year" => "1518"}}
  ...>   ]
  ...> } |> Sleepy.calc_guard()
  %Guard{
    id: 10,
    sleep_log: [
      %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}},
      %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "05", "month" => "11", "year" => "1518"}}
    ],
    sleep_mins: %{
      5 => 1, 6 => 1, 7 => 1, 8 => 1, 9 => 1, 10 => 1, 11 => 1, 12 => 1, 13 => 1, 14 => 1,
      15 => 1, 16 => 1, 17 => 1, 18 => 1, 19 => 1, 20 => 1, 21 => 1, 22 => 1, 23 => 1, 24 => 1
    },
    total_asleep: 20,
  }
  """
  def calc_guard(%Guard{sleep_log: sleep_log} = guard) do
    sleep_mins = sleep_log |> Enum.reverse() |> Enum.reduce(%{}, &Sleepy.calculate_mins/2)
    total_asleep = sleep_mins |> Map.values() |> Enum.sum()
    guard |> Map.merge(%{sleep_mins: sleep_mins, total_asleep: total_asleep})
  end


  @doc """
  parse sleep_log into sleep_mins

  NOTE sleep_log is logged in reverse-cron order, but needs to be in cron order to calculate

  so be sure to Enum.reverse before you use this reducer function

  ## Examples

      iex> Enum.reduce([
      ...>    %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "22", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "30", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "32", "month" => "11", "year" => "1518"}},
      ...> ], %{}, &Sleepy.calculate_mins/2)
      %{
        22 => 1,
        23 => 1,
        24 => 1,
        30 => 1,
        31 => 1,
      }

      iex> Enum.reduce([
      ...>    %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "22", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{start: %{"day" => "02", "hour" => "00", "min" => "20", "month" => "11", "year" => "1518"}},
      ...>    %TimeLog{stop: %{"day" => "02", "hour" => "00", "min" => "24", "month" => "11", "year" => "1518"}},
      ...> ], %{}, &Sleepy.calculate_mins/2)
      %{
        20 => 1,
        21 => 1,
        22 => 2,
        23 => 2,
        24 => 1,
      }
  """
  def calculate_mins(%TimeLog{start: start, stop: nil}, %{} = acc) do
    acc |> Map.merge(%{last_start: start})
  end
  def calculate_mins(%TimeLog{stop: stop, start: nil}, %{last_start: start} = acc) do
    # make a range for all min between last start and now
    start_min = start |> Map.get("min") |> String.to_integer()
    stop_min = stop |> Map.get("min") |> String.to_integer()
    range_min = Range.new(start_min, stop_min - 1)
    acc
    |> Map.merge(
      # for eacn min in range, increment the value within acc
      range_min |> Enum.reduce(
        acc,
        fn(min, acc_1) -> acc_1 |> Map.update(min, 1, &(&1 + 1)) end
      )
    )
    # now cleanup
    |> Map.delete(:last_start)
  end

  @doc """
  apply_log_line log lines into Guards, correctly

  ## Examples

      iex> Sleepy.apply_log_line("[1518-11-01 00:00] Guard #10 begins shift", %Guards{})
      %Guards{
        current_id: 10,
        guards: %{10 => %Guard{id: 10}}
      }

      iex> Enum.reduce([
      ...>   "[1518-11-01 00:00] Guard #10 begins shift",
      ...>   "[1518-11-01 00:05] falls asleep",
      ...>   "[1518-11-01 00:25] wakes up",
      ...> ], %Guards{}, &Sleepy.apply_log_line/2)
      %Guards{
        current_id: 10,
        guards: %{
          10 => %Guard{
            id: 10,
            sleep_log: [
              %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}},
              %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "05", "month" => "11", "year" => "1518"}}
            ]
          }
        }
      }
  """
  def apply_log_line(log, %Guards{} = guards_acc) when is_bitstring(log) do
    log |> parse() |> apply_log_line(guards_acc)
  end
  def apply_log_line(%Guard{id: id} = guard, %Guards{guards: guards} = guards_acc) do
    guards_acc |> Map.merge(%{
      current_id: id,
      guards: guards |> Map.put_new(id, guard),
    })
  end
  # skip if we get time before a guard id
  def apply_log_line(%TimeLog{}, %Guards{current_id: nil} = guards_acc), do: guards_acc
  def apply_log_line(%TimeLog{} = log, %Guards{current_id: id, guards: guards} = guards_acc) do
    guard = guards |> Map.get(id)
    sleep_log = guard |> Map.get(:sleep_log)
    guard = guard |> Map.merge(%{sleep_log: [log | sleep_log]})
    guards_acc |> Map.merge(%{
      guards: guards |> Map.put(id, guard),
    })
  end

  @doc """
  Parse lines into proper struct

  ## Examples

      iex> Sleepy.parse("[1518-11-01 00:00] Guard #10 begins shift")
      %Guard{id: 10}

      iex> Sleepy.parse("[1518-11-01 00:05] falls asleep")
      %TimeLog{start: %{"day" => "01", "hour" => "00", "min" => "05", "month" => "11", "year" => "1518"}}

      iex> Sleepy.parse("[1518-11-01 00:25] wakes up")
      %TimeLog{stop: %{"day" => "01", "hour" => "00", "min" => "25", "month" => "11", "year" => "1518"}}

  """
  def parse(str) when is_bitstring(str) do
    date = str |> parse_date()
    guard = ~r/ Guard #(?<id>[0-9]+)/ |> Regex.named_captures(str)
    cond do
      is_map(guard) ->
        %Guard{
          id: guard |> Map.get("id") |> String.to_integer(),
        }
      ~r/ falls asleep/ |> Regex.match?(str) -> %TimeLog{start: date}
      ~r/ wakes up/ |> Regex.match?(str) -> %TimeLog{stop: date}
      true -> nil
    end
  end

  @doc """

  ## Examples

      iex> Sleepy.parse_date("[1518-11-01 00:00] Guard #10 begins shift")
      %{"day" => "01", "hour" => "00", "min" => "00", "month" => "11", "year" => "1518"}
  """
  def parse_date(str) when is_bitstring(str) do
    ~r/\[(?<year>[0-9]{4})-(?<month>[0-9]{2})-(?<day>[0-9]{2}) (?<hour>[0-9]{2}):(?<min>[0-9]{2})\]/
      |> Regex.named_captures(str)
  end
end
