defmodule Aoc.Helpers do
  def intro(module) do
    puzzle = "Puzzle: #{name(module)}"
    length = String.length(puzzle)
    "#{fluff(length)}\n#{puzzle}\n#{fluff(length)}"
  end

  def solution(module, part, test? \\ false) do
    solution = module |> name() |> path(test?) |> File.read() |> solve(part, module)
    if test?, do: "#{solution} [TEST]", else: solution
  end

  def parse(lines), do: Enum.map(lines, &String.to_integer(&1))

  def transpose(matrix), do: matrix |> List.zip() |> Enum.map(&Tuple.to_list/1)

  defp name(module), do: module |> Atom.to_string() |> String.split(".") |> List.last()
  defp fluff(length), do: Enum.reduce(0..(length - 1), "", fn _e, acc -> "##{acc}" end)

  defp path(name, _test? = true), do: "input/#{name}Test.txt"
  defp path(name, _test? = false), do: "input/#{name}.txt"

  defp solve({:error, _error}, _part, _module), do: "*** NO INPUT ***"

  defp solve({:ok, input}, part, module),
    do: input |> String.split("\n", trim: true) |> module.solve(part)
end
