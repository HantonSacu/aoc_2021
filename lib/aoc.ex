defmodule Aoc do
  alias Aoc.Puzzles.{BinaryDiagnostic, Dive, Lanternfish, SonarSweep}

  def run do
    SonarSweep.run()
    Dive.run()
    BinaryDiagnostic.run()
    Lanternfish.run()
  end
end
