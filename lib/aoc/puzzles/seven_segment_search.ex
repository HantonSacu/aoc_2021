defmodule Aoc.Puzzles.SevenSegmentSearch do
  import Aoc.Helpers

  @module __MODULE__

  @map %{
    "a" => 0,
    "b" => 0,
    "c" => 0,
    "d" => 0,
    "e" => 0,
    "f" => 0,
    "g" => 0
  }

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

  def solve(lines, :first) do
    Enum.reduce(lines, 0, fn line, acc ->
      acc +
        (line
         |> String.split("|")
         |> List.last()
         |> String.split()
         |> Enum.filter(&(String.length(&1) in [2, 3, 4, 7]))
         |> length())
    end)
  end

  def solve(lines, :second) do
    lines
    |> Enum.map(fn line ->
      [a, b] = String.split(line, "|")
      input = String.split(a)
      map = count_letters(input, @map)

      n_1 = input |> Enum.filter(&(String.length(&1) == 2)) |> hd() |> String.graphemes()
      n_7 = input |> Enum.filter(&(String.length(&1) == 3)) |> hd() |> String.graphemes()
      n_4 = input |> Enum.filter(&(String.length(&1) == 4)) |> hd() |> String.graphemes()

      zero = hd(n_7 -- n_1)
      one = map |> Enum.find(fn {_key, value} -> value == 6 end) |> elem(0)
      four = map |> Enum.find(fn {_key, value} -> value == 4 end) |> elem(0)
      five = map |> Enum.find(fn {_key, value} -> value == 9 end) |> elem(0)
      two = hd(n_7 -- [zero, five])
      three = hd(n_4 -- [one, two, five])
      six = hd(["a", "b", "c", "d", "e", "f", "g"] -- [zero, one, two, three, four, five])

      input = String.split(b)

      map = %{
        "#{zero}#{one}#{two}#{four}#{five}#{six}" => 0,
        "#{two}#{five}" => 1,
        "#{zero}#{two}#{three}#{four}#{six}" => 2,
        "#{zero}#{two}#{three}#{five}#{six}" => 3,
        "#{one}#{two}#{three}#{five}" => 4,
        "#{zero}#{one}#{three}#{five}#{six}" => 5,
        "#{zero}#{one}#{three}#{four}#{five}#{six}" => 6,
        "#{zero}#{two}#{five}" => 7,
        "#{zero}#{one}#{two}#{three}#{four}#{five}#{six}" => 8,
        "#{zero}#{one}#{two}#{three}#{five}#{six}" => 9
      }

      Enum.reduce(input, [], fn e, acc ->
        i = e |> String.graphemes() |> Enum.sort()

        [{_k, n}] =
          Enum.filter(Map.to_list(map), fn {key, _value} ->
            i == Enum.sort(String.graphemes(key))
          end)

        [n | acc]
      end)
      |> Enum.reduce("", &"#{&1}#{&2}")
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp count_letters([], map), do: map

  defp count_letters([head | tail], map) do
    map =
      Enum.reduce(String.graphemes(head), map, fn c, map -> Map.update!(map, c, &(&1 + 1)) end)

    count_letters(tail, map)
  end
end
