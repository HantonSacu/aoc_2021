defmodule Aoc.Puzzles.Lanternfish do
  use Memoizer

  import Aoc.Helpers

  @module __MODULE__

  @map %{"1" => 0, "2" => 0, "3" => 0, "4" => 0, "5" => 0, "6" => 0, "7" => 0, "8" => 0, "9" => 0}

  def run do
    IO.puts(intro(@module))
    IO.puts("How many lanternfish would there be after 80 days?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first))
    IO.puts("How many lanternfish would there be after 256 days?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second))
    IO.puts("***************************************************")
  end

  def solve([line], part) do
    n = line |> String.split(",") |> parse()
    map = Enum.reduce(n, @map, fn e, acc -> Map.update!(acc, "#{e}", &(&1 + 1)) end)
    days = if part == :first, do: 80, else: 256

    Stream.map(Enum.uniq(n), &(algorithm(0, days - &1) * Map.get(map, "#{&1}")))
    |> Enum.to_list()
    |> Enum.sum()
  end

  def algorithm(_n, days) when days <= 0, do: 1
  defmemo(algorithm(0, days), do: algorithm(6, days - 1) + algorithm(8, days - 1))
  defmemo(algorithm(n, days), do: algorithm(0, days - n))
end
