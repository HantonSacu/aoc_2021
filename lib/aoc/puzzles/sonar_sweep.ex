defmodule Aoc.Puzzles.SonarSweep do
  import Aoc.Helpers

  @module __MODULE__

  def run do
    IO.puts(intro(@module))
    IO.puts("How many measurements are larger than the previous measurement?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first))
    IO.puts("How many sums are larger than the previous sum?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second))
    IO.puts("***************************************************************")
  end

  def solve(lines, part) do
    [first | rest] = if part == :first, do: parse(lines), else: lines |> parse() |> sum_3rd([])
    algorithm(first, rest, 0)
  end

  defp algorithm(_current, [], solution), do: solution
  defp algorithm(c, [n | rest], solution) when n > c, do: algorithm(n, rest, solution + 1)
  defp algorithm(c, [n | rest], solution) when n <= c, do: algorithm(n, rest, solution)

  defp sum_3rd([a, b, c | rest], list), do: sum_3rd([b, c | rest], [a + b + c | list])
  defp sum_3rd(_numbers, list), do: Enum.reverse(list)
end
