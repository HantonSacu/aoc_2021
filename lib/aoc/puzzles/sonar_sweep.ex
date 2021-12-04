defmodule Aoc.Puzzles.SonarSweep do
  import Aoc.Helpers

  @module __MODULE__

  def run do
    IO.puts(intro(@module))
    IO.puts("How many measurements are larger than the previous measurement?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first, _test? = false))
    IO.puts("How many sums are larger than the previous sum?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second, _test? = false))
    IO.puts("***************************************************************")
  end

  def solve(lines, :first) do
    [first | rest] = parse(lines)
    algorithm(first, rest, 0)
  end

  def solve(lines, :second) do
    [first | rest] = lines |> parse() |> sum_3rd([]) |> Enum.reverse()
    algorithm(first, rest, 0)
  end

  defp algorithm(_current, [], solution), do: solution
  defp algorithm(c, [n | rest], solution) when n > c, do: algorithm(n, rest, solution + 1)
  defp algorithm(c, [n | rest], solution) when n <= c, do: algorithm(n, rest, solution)

  defp sum_3rd([a, b, c | rest], list), do: sum_3rd([b, c | rest], [a + b + c | list])
  defp sum_3rd(_numbers, list), do: list
end
