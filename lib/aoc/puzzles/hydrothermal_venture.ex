defmodule Aoc.Puzzles.HydrothermalVenture do
  import Aoc.Helpers

  @module __MODULE__

  def run do
    IO.puts(intro(@module))
    IO.puts("At how many points do at least two lines overlap?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first, _test? = false))
    IO.puts("At how many points do at least two lines overlap?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second, _test? = false))
    IO.puts("********************************")
  end

  def solve(lines, part) do
    Enum.reduce(lines, [], fn l, acc ->
      [a, b] = String.split(l, "->")
      [x1, y1] = a |> String.split(",") |> Enum.map(&String.trim/1) |> parse()
      [x2, y2] = b |> String.split(",") |> Enum.map(&String.trim/1) |> parse()

      if x1 == x2 or y1 == y2 do
        [e(x1, y1, x2, y2, [[x1, y1]]) | acc]
      else
        if part == :first, do: acc, else: [ed(x1, y1, x2, y2, [[x1, y1]]) | acc]
      end
    end)
    |> Enum.reduce(%{}, fn elements, acc ->
      Enum.reduce(elements, acc, fn [x, y], map ->
        k = "#{x}_#{y}"

        if Map.has_key?(map, k), do: Map.update!(map, k, &(&1 + 1)), else: Map.put(map, k, 1)
      end)
    end)
    |> Enum.reduce(0, fn {_k, v}, counter -> if v >= 2, do: counter + 1, else: counter end)
  end

  defp e(x1, y1, x2, y2, list) when x1 == x2 and y1 == y2, do: list
  defp e(x1, y1, x2, y2, list) when x1 < x2, do: e(x1 + 1, y1, x2, y2, [[x1 + 1, y1] | list])
  defp e(x1, y1, x2, y2, list) when x1 > x2, do: e(x1 - 1, y1, x2, y2, [[x1 - 1, y1] | list])
  defp e(x1, y1, x2, y2, list) when y1 < y2, do: e(x1, y1 + 1, x2, y2, [[x1, y1 + 1] | list])
  defp e(x1, y1, x2, y2, list) when y1 > y2, do: e(x1, y1 - 1, x2, y2, [[x1, y1 - 1] | list])

  defp ed(x1, y1, x2, y2, list) when x1 == x2 and y1 == y2, do: list

  defp ed(x1, y1, x2, y2, list) when x1 < x2 and y1 < y2,
    do: ed(x1 + 1, y1 + 1, x2, y2, [[x1 + 1, y1 + 1] | list])

  defp ed(x1, y1, x2, y2, list) when x1 > x2 and y1 > y2,
    do: ed(x1 - 1, y1 - 1, x2, y2, [[x1 - 1, y1 - 1] | list])

  defp ed(x1, y1, x2, y2, list) when x1 < x2 and y1 > y2,
    do: ed(x1 + 1, y1 - 1, x2, y2, [[x1 + 1, y1 - 1] | list])

  defp ed(x1, y1, x2, y2, list) when x1 > x2 and y1 < y2,
    do: ed(x1 - 1, y1 + 1, x2, y2, [[x1 - 1, y1 + 1] | list])
end
