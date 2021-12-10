defmodule Aoc do
  alias Aoc.Puzzles.{BinaryDiagnostic, Dive, SevenSegmentSearch, SonarSweep}

  def run do
    SonarSweep.run()
    Dive.run()
    BinaryDiagnostic.run()
    SevenSegmentSearch.run()
  end
end
