defmodule Aoc.Puzzles.BinaryDiagnostic do
  import Aoc.Helpers

  @module __MODULE__

  def run do
    IO.puts(intro(@module))
    IO.puts("What is the power consumption of the submarine?")
    IO.puts(solution(@module, :first, _test? = true))
    IO.puts(solution(@module, :first))
    IO.puts("What is the life support rating of the submarine?")
    IO.puts(solution(@module, :second, _test? = true))
    IO.puts(solution(@module, :second))
    IO.puts("*************************************************")
  end

  def solve(lines, part) do
    m = Enum.map(lines, &String.graphemes/1)
    if part == :first, do: a(m, :most) * a(m, :least), else: b(m, :most) * b(m, :least)
  end

  defp a(m, t), do: m |> eval(t) |> Enum.reverse() |> crunch(0, 0)
  defp b(m, t), do: m |> filter(0, t) |> crunch(0, 0)

  defp algorithm([], _type, solution), do: Enum.reverse(solution)
  defp algorithm([h | r], t, s), do: algorithm(r, t, [calculate(h, t) | s])

  defp filter([solution], _index, _type), do: Enum.reverse(solution)
  defp filter(m, i, t), do: m |> filter_by(i, t) |> filter(i + 1, t)
  defp filter_by(m, i, t), do: Enum.filter(m, &(Enum.at(&1, i) == Enum.at(eval(m, t), i)))
  defp eval(m, t), do: m |> transpose() |> Enum.reverse() |> algorithm(t, []) |> Enum.reverse()

  defp calculate(col, :most) do
    if number_of("1", col) >= number_of("0", col), do: "1", else: "0"
  end

  defp calculate(col, :least) do
    if number_of("0", col) <= number_of("1", col), do: "0", else: "1"
  end

  defp crunch([], _power, solution), do: solution
  defp crunch([h | r], p, s), do: crunch(r, p + 1, s + mul_pow(h, p))

  defp number_of(v, col), do: col |> Enum.filter(&(&1 == v)) |> length()
  defp mul_pow(b, p), do: String.to_integer(b) * (2 |> :math.pow(p) |> round())
end
