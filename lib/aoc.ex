defmodule Aoc do
  alias Aoc.Puzzles.{Dive, SonarSweep}

  def run do
    SonarSweep.run()
    Dive.run()
  end
end
