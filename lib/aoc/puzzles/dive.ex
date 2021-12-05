defmodule Aoc.Puzzles.Dive do
  import Aoc.Helpers

  @module __MODULE__

  def run do
    IO.puts(intro(@module))
    IO.puts("What do you get if you multiply your final horizontal position by your final depth?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first))
    IO.puts("What do you get if you multiply your final horizontal position by your final depth?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second))
    IO.puts("***********************************************************************************")
  end

  def solve(lines, part) do
    input = Enum.map(lines, &(&1 |> String.split() |> parse_input()))
    if part == :first, do: algorithm(input, 0, 0), else: algorithm(input, 0, 0, 0)
  end

  defp algorithm([], p, d), do: p * d
  defp algorithm([{:forward, v} | r], p, d), do: algorithm(r, p + v, d)
  defp algorithm([{:down, v} | r], p, d), do: algorithm(r, p, d + v)
  defp algorithm([{:up, v} | r], p, d), do: algorithm(r, p, d - v)

  defp algorithm([], p, d, _a), do: p * d
  defp algorithm([{:forward, v} | r], p, d, a), do: algorithm(r, p + v, d + a * v, a)
  defp algorithm([{:down, v} | r], p, d, a), do: algorithm(r, p, d, a + v)
  defp algorithm([{:up, v} | r], p, d, a), do: algorithm(r, p, d, a - v)

  defp parse_input([d, v]), do: {String.to_atom(d), String.to_integer(v)}
end
