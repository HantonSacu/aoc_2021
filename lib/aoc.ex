defmodule Aoc do
  alias Aoc.Puzzles.{BinaryDiagnostic, Dive, SonarSweep}

  def run do
    SonarSweep.run()
    Dive.run()
    BinaryDiagnostic.run()
  end
end
